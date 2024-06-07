# Solution

Change the workflow definition in the file `custom-message.yaml` so that it can accept a argument parameter named `message`. Use the parameter to render the passed in value in the `echo` command. The final workflow definition could look as follows:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: custom-message-
spec:
  arguments:
    parameters:
      - name: message
        value: Hello World!
  entrypoint: hello-world
  templates:
  - name: hello-world
    inputs:
      parameters:
        - name: message
    container:
      image: alpine:3.19.1
      command: [echo]
      args: ["{{inputs.parameters.message}}"]
```

Use the `-p` command line flag to pass a value for the parameter `message`. The command below provides the message "Provided from the CLI" and executes the workflow in the `argo` namespace.

```
$ argo submit -n argo -p 'message="Provided from the CLI"' --watch custom-message.yaml
Name:                custom-message-6px5s
Namespace:           argo
ServiceAccount:      unset (will run with the default ServiceAccount)
Status:              Succeeded
Conditions:
 PodRunning          False
 Completed           True
Created:             Fri Jun 07 10:49:39 -0600 (20 seconds ago)
Started:             Fri Jun 07 10:49:50 -0600 (9 seconds ago)
Finished:            Fri Jun 07 10:50:00 -0600 (now)
Duration:            10 seconds
Progress:            1/1
ResourcesDuration:   0s*(1 cpu),2s*(100Mi memory)
Parameters:
  message:           "Provided from the CLI"

STEP                     TEMPLATE     PODNAME               DURATION  MESSAGE
 ✔ custom-message-6px5s  hello-world  custom-message-6px5s  5s
```

To retrieve the logs of the last workflow execution, run the following command.

```
$ argo logs -n argo -f @latest
custom-message-6px5s: time="2024-06-07T16:49:53.911Z" level=info msg="capturing logs" argo=true
custom-message-6px5s: "Provided from the CLI"
custom-message-6px5s: time="2024-06-07T16:49:54.913Z" level=info msg="sub-process exited" argo=true error="<nil>"
```