# Exercise 6

Your team decides to use Argo Workflows to create a Kubernetes Deployment to the namespace `app`. In this exercise, you'll define and execute a workflow for creating the object.

> [!IMPORTANT]
> Apply the workflow RBAC permissions in the file [`workflow-rbac.yaml`](./workflow-rbac.yaml) to execute the workflow in the namespace `app` with the ServiceAccount `app-sa`.

1. Define a new workflow in the file `deployment-resource-workflow.yaml`. The workflow should use a resource template for creating a Deployment object in the `app` namespace. Make the number of replicas (defaults to 3) and the container image tag (defaults to `1.25.4-alpine`) configurable. The workflow should be executed by the ServiceAccount `app-sa`.
2. Submit the workflow to be executed in the `argo` namespace.
3. List the Deployment objects and its replicas in the `argo` namespace.