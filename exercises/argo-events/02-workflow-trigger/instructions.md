# Exercise 2

You have been asked to set up an endpoint for triggering an Argo workflow. Define the necessary Argo events components and observe the workflow execution after sending a request to the endpoint.

> [!NOTE]
> Ensure to install [Argo Workflows](./https://argo-workflows.readthedocs.io/en/latest/) with cluster-scope configuration before working on this exercise.

1. Setup an event source for a webhook in the namespace `argo-events`. The webhook should define a single event configuration that runs an HTTP server on port 12000 with the endpoint `whalesay`.
2. Create a Role and RoleBinding to allow the `default` service account to trigger workflows. More specifically the permissions enable a Workflow Pod (running Emissary executor) to be able to read and patch WorkflowTaskResults.
3. Create a sensor that accepts the events from the webhook endpoint as dependency. Parse a single parameter from the request body and map it to the name `message`. The workflow to be submitted should be defined directly inside of the sensor. Submit the workflow in a container template that uses `docker/whalesay:latest`. Print the `message` parameter to standard output.
4. Create a service account named `operate-workflow-sa` and wire it with a RoleBinding that binds to a Role allowing all operations for the resources `workflows`, `workflowtemplates`, `cronworkflows`, and `clusterworkflowtemplates`.
5. Expose the event source Pod via port forwarding to consume HTTP requests on port `12000`.