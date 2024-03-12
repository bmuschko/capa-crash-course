# Solution

> [!NOTE]
> You can execute all commands mentioned below with the shell script [setup-webhook.sh](./setup-webhook.sh).

Define the event source in the file `webhook-event-source.yaml`. Expose the endpoint `pod-creation` on port 12000. Create the object.

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
    kubernetes:
      port: "12000"
      endpoint: /pod-creation
      method: POST
```

Define the sensor in the file `pod-sensor.yaml`. The contents of the file is shown below. Create the object.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Sensor
metadata:
  name: webhook
spec:
  template:
    serviceAccountName: argo-events-sa
  dependencies:
  - name: payload
    eventSourceName: webhook
    eventName: kubernetes
  triggers:
  - template:
      name: payload
      k8s:
        group: ""
        version: v1
        resource: pods
        operation: create
        source:
          resource:
            apiVersion: v1
            kind: Pod
            metadata:
              generateName: payload-
              labels:
                app: payload
            spec:
              containers:
              - name: alpine
                image: alpine:3.19.1
                command: ["echo"]
                args: ["Received message:\n", ""]
              restartPolicy: Never
        parameters:
          - src:
              dependencyName: payload
              dataKey: body.message
            dest: spec.containers.0.args.1
```

Perform a HTTP request using the POST method to the event source endpoint. Ensure to the provide the `message` parameter with the request body. The following command uses `curl`. The response should indicate `success`.

```
$ curl -X POST -d '{"message":"This is a message"}' -H "Content-Type: application/json" http://localhost:12000/pod-creation
success
```

The trigger should now create a new Pod in the `argo-events` namespace.

```
$ kubectl get pods -n argo-events
NAME                                         READY   STATUS      RESTARTS      AGE
payload-fmxwh                                0/1     Completed   0             23s
```

The logs of the Pod will render the message provided with the `curl` command.

```
$ kubectl logs payload-fmxwh -n argo-events
Received message:
 This is a message
```