# Exercise 2

You are tasked to write a simple Argo workflow that prints the message "Hello World" in a container.

1. Create a new file named `hello-world.yaml`.
2. Define the workflow with the name prefix `hello-world-` with a container template definition. The template runs the container image `alpine:3.19.1` and runs the command `echo 'Hello World!`.
3. Create and execute the workflow from the Argo Workflows UI. Check the logs of the workflow execution to see that the correct message has been printed to standard output.
4. Execute the workflow from the Argo CLI in the `argo` namespace. Watch the execution of the command.
5. Make the message to be printed configurable through a parameter. Provide a custom message when executing the workflow through the CLI.