# Exercise 3

In this exercise, you'll learn how to implement the canary deployment strategy with the help of Argo Rollouts. You'll start by deploying an application stack that runs the container image `nginx:1.25.3-alpine` (blue deployment). Later, you'll upgrade to the container image `nginx:1.25.4-alpine` (green deployment). In this scenario, you will need to manually promote the new ReplicaSet of the green deployment.

1. Inspect the existing setup in the [`canary`](./canary) directory. The files set up a Rollout definition, and two Service definitions, one for routing traffic to the stable and one for the canary deployment. The setup uses the Nginx Ingress Controller for enabling traffic management.
2. Create a new application using the Argo CD UI. Use the following configuration details:

    - Application name: nginx
    - Project: default
    - Sync Policy: Manual
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-rollouts/03-canary-deployment/canary`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`