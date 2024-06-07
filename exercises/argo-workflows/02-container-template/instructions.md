# Exercise 2

You are tasked to write a simple Argo workflow that prints the message "Hello World" to standard output in a container.

1. Create a new file named `hello-world.yaml`. Within the file, define a workflow with the name prefix `hello-world-` using a container template definition. The template runs the container image `alpine:3.19.1` and runs the command `echo 'Hello World!`.
2. Create and execute the workflow from the Argo Workflows UI. Check the logs of the workflow execution to see that the correct message has been printed to standard output. Run the Argo command from the CLI to retrieve the logs.
3. Execute the workflow from the Argo CLI in the `argo` namespace. Watch the execution of the command.
4. Retrieve the logs for the workflow execution from the CLI.