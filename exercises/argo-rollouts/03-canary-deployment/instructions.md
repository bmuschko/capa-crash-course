# Exercise 3

In this exercise, you'll learn how to implement the canary deployment strategy with the help of Argo Rollouts. You'll start by deploying a web application that runs the container image `bmuschko/canary-app:1.0.0`. The application URL is accessible on the root context path on port 80. Later, you'll upgrade to the container image to `bmuschko/canary-app:2.0.0`. In this scenario, you will need to manually promote the new ReplicaSet of the initial deployment.

1. Inspect the existing setup in the [`canary`](./canary) directory. The files set up a Rollout definition, and two Service definitions, one for routing traffic to the stable and one for the canary deployment. The setup uses [Apache APISIX](https://apisix.apache.org/) for traffic routing.
2. Install the APISIX and the ingress controller using Helm. You can find installation instructions [here](https://apisix.apache.org/docs/ingress-controller/deployments/minikube/). Alternatively, run the [install-apisix.sh](./install-apisix.sh).
3. Create a new application using the Argo CD UI. Use the following configuration details:

    - Application name: webapp
    - Project: default
    - Sync Policy: Manual
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-rollouts/03-canary-deployment/canary`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

4. Using the `argo rollouts` command, list all rollouts, get the status of the `nginx-rollout` rollout, and render its details.
5. Get the application URL by getting the IP address and node port of the Service `apisix-gateway` in the namespace `ingress-apisix`.
6. Make a call to both Service endpoints to verify which application version is running.
7. Set the container image `bmuschko/canary-app:2.0.0` for the rollout using the imperative `kubectl argo rollouts set image` command.
8. Promote the rollout and check its details.
9. Make a call to both Service endpoints to verify which application version is running. Only 25% of the requests will hit the new application version.
10. Promote the rollout and check its details.
11. Make a call to both Service endpoints to verify which application version is running. 100% of the requests will hit the new application version.
