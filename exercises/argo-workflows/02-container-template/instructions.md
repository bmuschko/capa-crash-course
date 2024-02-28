# Exercise 2

You are tasked to write a simple Argo workflow that prints the message "Hello World" to standard output in a container. Later, you'll make the message configurable by exposing an input to the workflow.

1. Create a new file named `hello-world.yaml`. Within the file, define a workflow with the name prefix `hello-world-` using a container template definition. The template runs the container image `alpine:3.19.1` and runs the command `echo 'Hello World!`. Ensure that the workflow will be executed in the `argo` namespace.
2. Create and execute the workflow from the Argo Workflows UI. Check the logs of the workflow execution to see that the correct message has been printed to standard output. Run the Argo command from the CLI to retrieve the logs.
3. Execute the workflow from the Argo CLI in the `user-workflows` namespace. Watch the execution of the command.
4. Copy the contents of the file `hello-world.yaml` to a new file named `custom-message.yaml`. Change the configuration of the workflow definition, so that the message can be provided through a parameter.
5. Execute the workflow in `custom-message.yaml` in the `argo` namespace. Provide a custom message as the input to the workflow.
