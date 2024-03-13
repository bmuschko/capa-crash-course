# Exercise 5

In this exercise, you will learn how to deploy an application as a Helm chart through the UI, and the declarative way with the CLI.

1. Inspect the Helm Chart files in the [`nginx`](./nginx) directory to understand their purpose.
2. Create a new application using the Argo CD UI. Use the default values, but set 6 replicas instead of 3. Use the following configuration details:

    - Application name: nginx
    - Project: default
    - Sync Policy: Automatic
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-cd/05-helm-deployment/nginx`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

3. Inspect the application in the UI.
4. Delete the application using the CLI and create the same application setup using the CLI.
5. Run the `helm list --all-namespaces` command to verify that Argo CD does not use the `install` command for Helm charts.