# Exercise 3

You are tasked to modify an existing Argo workflow to make a message configurable printed to standard output in a container. Introduce a parameter argument that allows end users to provide a value for the message upon creation of the workflow.

1. Inspect the existing workflow in the file [`custom-message.yaml`](./custom-message.yaml).
2. Change the configuration of the workflow definition, so that a message can be provided through an argument. Pass the argument to the template and use its assigned value when executing the container image.
3. Submit the workflow to be executed in the `argo` namespace. Provide a custom message as argument value to the workflow.
4. Ensure that the custom message has been rendered to standard output within the container.