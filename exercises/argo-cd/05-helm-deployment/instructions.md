# Exercise 5

In this exercise, you will learn how to deploy an application as a Helm chart.

1. Inspect the Chart files in the [`nginx`](./nginx) directory to understand their purpose.
2. Create a new application using the Argo CD UI that uses the automatic sync policy. Use the following configuration details:

    - Application name: nginx
    - Project: default
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-cd/05-helm-deployment/nginx`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

3. Inspect the application in the UI.
4. Delete the application using the CLI and create/sync the same application using the CLI.