# Solution

> [!NOTE]
> You can execute all commands mentioned below with the shell script [setup-webhook.sh](./setup-webhook.sh).

Define the event source in the file `webhook-event-source.yaml`. Expose the endpoint `whalesay` on port 12000. Create the object.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: EventSource
metadata:
  name: webhook
spec:
  service:
    ports:
      - port: 12000
        targetPort: 12000
  webhook:
    whalesay:
      port: "12000"
      endpoint: /whalesay
      method: POST
```

Create the RBAC permissions for the resource `workflowtaskresults` with the verbs `create` and `patch` for the `default` service account. You can find the definition in the file [`workflow-rbac.yaml`](./workflow-rbac.yaml). Create the objects.

Define the sensor in the file `special-workflow-trigger-shortened.yaml`. The contents of the file is shown below. Create the object.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Sensor
metadata:
  name: webhook
spec:
  template:
    serviceAccountName: operate-workflow-sa
  dependencies:
    - name: webhook-dep
      eventSourceName: webhook
      eventName: whalesay
  triggers:
    - template:
        name: argo-workflow-trigger
        argoWorkflow:
          operation: submit
          source:
            resource:
              apiVersion: argoproj.io/v1alpha1
              kind: Workflow
              metadata:
                generateName: webhook-
              spec:
                entrypoint: whalesay
                arguments:
                  parameters:
                    - name: message
                      value: hello world
                templates:
                  - name: whalesay
                    inputs:
                      parameters:
                        - name: message
                    container:
                      image: docker/whalesay:latest
                      command: [cowsay]
                      args: ["{{inputs.parameters.message}}"]
          parameters:
            - src:
                dependencyName: webhook-dep
                dataKey: body
              dest: spec.arguments.parameters.0.value
```

The RBAC permissions for the sensor. You can find an example in [`sensor-rbac.yaml`](./sensor-rbac.yaml). Create the objects.

Perform a HTTP request using the POST method to the event source endpoint. Ensure to the provide the `message` parameter with the request body. The following command uses `curl`. The response should indicate `success`.

```
$ curl -X POST -d '{"message":"This is a message"}' -H "Content-Type: application/json" http://localhost:12000/whalesay
success
```

You should find that a workflow should have been submitted and is running in the `argo-events` workflow. The following command shows a completed workflow execution.

```
$ argo list -n argo-events
NAME            STATUS      AGE   DURATION   PRIORITY   MESSAGE
webhook-zxln9   Succeeded   33s   10s        0
```

The EventSource object automatically exposes a health endpoint. You can target it using the following command.

```
$ curl -X POST -H "Content-Type: application/json" http://localhost:12000/health
OK
```

A HTTP request to the health endpoint returns the response message `OK` with response code 200.
