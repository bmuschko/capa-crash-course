# Exercise 4

Your team decides to use Argo Workflows to create a Kubernetes Deployment to the namespace `app`. In this exercise, you'll define and execute a workflow for creating the object.

1. Create the namespace `app`.
2. Create a service account named `app-sa` in the namespace `argo`. Create a RoleBinding named `app-rolebinding` in the namespace `app` that binds the service account to `admin` ClusterRole.
3. Define a new workflow in the file `deployment-resource-workflow.yaml`. The workflow should use a resource template for creating a Deployment object in the `app` namespace. Make the number of replicas (defaults to 3) and the container image tag (defaults to `1.25.4-alpine`) configurable.
4. Submit the workflow to be executed in the `argo` namespace.
5. List the Deployment objects and its replicas in the `argo` namespace.