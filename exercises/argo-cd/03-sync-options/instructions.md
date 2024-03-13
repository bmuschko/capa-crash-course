# Exercise 3

In this exercise, you will learn about the auto-sync, self-heal, and auto-prune options.

1. Inspect the YAML manifests in the [`nginx`](./nginx) directory to understand their purpose.
2. Create a new application using the Argo CD UI that uses the automatic sync policy. Use the following configuration details:

    - Application name: nginx
    - Project: default
    - Sync Policy: Automatic
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-cd/03-sync-options/nginx`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

3. Change the container image tag used in the Deployment manifest to `1.25.4-alpine`. Commit and push the change to GitHub. Wait until Argo CD will automatically sync those changes. By default, this happens after 3 minutes. You can change the default polling interval, as described [here](https://argo-cd.readthedocs.io/en/stable/faq/#how-often-does-argo-cd-check-for-changes-to-my-git-or-helm-repository).
4. Scale the number of replicas to 5 using the imperative `kubectl scale` command. Enable the "Self Heal" option for the application in the "Sync Policy" section. You should see that the number of replicas will be reverted to 3.
5. Delete the Service YAML manifest in the GitHub repository. Commit and push the change to GitHub. The application will indicate the "OutOfSync" status. Enable the "Prune Resources" option for the application in the "Sync Policy" section. You should see that the Service object will be removed automatically.