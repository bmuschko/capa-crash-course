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
          value: "{{workflow.parameters.message}}"
    container:
      image: alpine:3.19.1
      command: [echo]
      args: ["{{inputs.parameters.message}}"]
```

Use the `-p` command line flag to pass a value for the parameter `message`. The command below provides the message "Provided from the CLI" and executes the workflow in the `argo` namespace.

```
$ argo submit -n argo -p 'message="Provided from the CLI"' --watch custom-message.yaml
```