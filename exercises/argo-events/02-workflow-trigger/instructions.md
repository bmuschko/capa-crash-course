# Exercise 2

> [!NOTE]
> Ensure to install [Argo Workflows](./https://argo-workflows.readthedocs.io/en/latest/) with cluster-scope configuration.

1. Setup event-source for webhook that contains a single event configuration that runs an HTTP server on port 12000 with endpoint `example`.
2. Create a service account with RBAC settings to allow the sensor to trigger workflows, and allow workflows to function.
3. Create webhook sensor.
4. Expose the event-source Pod via port forwarding to consume requests over HTTP.