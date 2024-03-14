# Exercise 6

In this exercise, you will learn how to deploy a Kustomize application through the UI, and the declarative way with the CLI.

1. Inspect the Kustomize files in the [`nginx`](./nginx) directory to understand their purpose.
2. Create a new application using the Argo CD UI. Select the `prod` overlay. Use the following configuration details:

    - Application name: nginx
    - Project: default
    - Sync Policy: Automatic
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-cd/06-kustomize-deployment/nginx/overlays/prod`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

3. Inspect the application in the UI.
4. Delete the application using the CLI and create the same application setup using the CLI.