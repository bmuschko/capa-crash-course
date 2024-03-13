# Exercise 4

1. Create a Application YAML manifest that manages the application with the following configuration details:

    - Application name: nginx
    - Project: default
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-cd/04-declarative-application/nginx`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

2. Apply the YAML manifest to create the application declaratively.