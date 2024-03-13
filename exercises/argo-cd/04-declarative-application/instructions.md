# Exercise 4

1. Create a Application YAML manifest that manages the application with the following configuration details:

    - Application name: nginx
    - Project: default
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-cd/04-declarative-application/nginx`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

2. Create the application declaratively in the `argocd` namespace using the the YAML manifest with the Argo CD CLI.
3. Inspect the application in the Argo CD UI. Sync the application.
4. Delete the application declaratively in the `argocd` namespace using the Argo CD CLI.
5. Implement the [App of Apps pattern](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/#app-of-apps-pattern) by creating two Application YAML manifests that point to the nginx application. Create the application from both application. Each application should runs its objects in a dedicated namespace.
6. Observe the created applications in the Argo CD UI.