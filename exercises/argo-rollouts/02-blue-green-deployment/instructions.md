# Exercise 2

In this exercise, you'll learn how to implement the blue-green deployment with the help of Argo Rollouts.

1. Inspect the existing setup in the [nginx](./blue-green) directory. The files set up a Rollout definition, and two Service definitions, one for blue and one for green.
2. Create a new application using the Argo CD UI. Use the following configuration details:

    - Application name: nginx
    - Project: default
    - Sync Policy: Manual
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-rollouts/02-blue-green-deployment/blue-green`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

3. Using the `argo rollouts` command, list all rollouts, get the status of the `nginx-rollout` rollout, and render its details.