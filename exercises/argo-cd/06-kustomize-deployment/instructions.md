# Exercise 6

In this exercise, you will learn how to deploy a Kustomize application through the UI, and the declarative way with the CLI.

1. Inspect the Kustomize files in the [`nginx`](./nginx) directory to understand their purpose.
2. Create a new application using the Argo CD UI. Use the default values, but set 6 replicas instead of 3. Use the following configuration details:

    - Application name: nginx
    - Project: default
    - Sync Policy: Automatic
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-cd/06-kustomize-deployment/nginx`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`