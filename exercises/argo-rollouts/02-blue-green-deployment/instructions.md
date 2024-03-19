# Exercise 2

In this exercise, you'll learn how to implement the blue-green deployment with the help of Argo Rollouts. You'll start by deploying an application stack that runs the container image `nginx:1.25.3-alpine` (blue deployment). Later, you'll upgrade to the container image `nginx:1.25.4-alpine` (green deployment). In this scenario, you will need to manually promote the new ReplicaSet of the green deployment.

1. Inspect the existing setup in the [`blue-green`](./blue-green) directory. The files set up a Rollout definition, and two Service definitions, one for routing traffic to the blue and one for the green deployment.
2. Create a new application using the Argo CD UI. Use the following configuration details:

    - Application name: nginx
    - Project: default
    - Sync Policy: Manual
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-rollouts/02-blue-green-deployment/blue-green`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

3. Using the `argo rollouts` command, list all rollouts, get the status of the `nginx-rollout` rollout, and render its details.
4. Make a call to both Service endpoints to verify which nginx version is running.
5. Set the container image `nginx:1.25.4-alpine` for the rollout using the imperative `kubectl argo rollouts set image` command.
6. Make a call to both Service endpoints to verify which nginx version is running.
7. Promote the rollout and check its details.
8. Make a call to both Service endpoints to verify which nginx version is running.