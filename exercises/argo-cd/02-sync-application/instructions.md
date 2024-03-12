# Exercise 2

Your team wants to deploy nginx with the help of Argo CD. You can find the YAML manifests required for nginx in the [`nginx`](./nginx) folder. Refer to the application manifests in Argo CD via https://github.com/bmuschko/capa-crash-course/tree/main/argo-cd/02-sync-application/nginx.

1. Inspect the YAML manifests to understand their purpose.
2. Create a new application using the Argo CD UI. Use the following configuration details:
* Application name: nginx
* Project: default
* Repository URL: https://github.com/codefresh-contrib/gitops-certification-examples
* Path: `./argo-cd/02-sync-application/app`
* Cluster: https://kubernetes.default.svc
* Namespace: `default`
3. The application will indicate the status "OutOfSync". Synchronize the application so that the Git state will be reflected in the cluster state.
4. Retrieve the list of Deployments and Service in the `default` namespace. You should find your deployed application.
5. Use the Argo CD CLI to list all applications, get the details of the `nginx` application and its history.
6. Delete the `nginx` application using the CLI and create/sync the same application using the CLI.