# Exercise 4

In this exercise, you'll learn how to implement the canary deployment strategy with the help of Argo Rollouts. The promotion progress will be overseen by a Job-based analysis run. You'll start by deploying a web application that runs the container image `bmuschko/canary-app:1.0.0`. The application URL is accessible on the root context path on port 80. Later, you'll upgrade to the container image to `bmuschko/canary-app:2.0.0`. In this scenario, promotion will happen automatically every minute. The analysis run will always return success, though you will find another analysis template that randomly returns a failure if you want to emulate other behavior.

1. Inspect the existing setup in the [`analysis-template-job`](./analysis-template-job) directory. The files set up a Rollout definition, and two Service definitions, one for routing traffic to the stable and one for the canary deployment. The setup uses [Apache APISIX](https://apisix.apache.org/) for traffic routing.
2. Install the APISIX and the ingress controller using Helm. You can find installation instructions [here](https://apisix.apache.org/docs/ingress-controller/deployments/minikube/). Alternatively, run the [install-apisix.sh](../traffic-routing/install-apisix.sh).
3. Create a new application using the Argo CD UI. Use the following configuration details:

    - Application name: webapp
    - Project: default
    - Sync Policy: Manual
    - Repository URL: https://github.com/bmuschko/capa-crash-course
    - Path: `./exercises/argo-rollouts/04-analysis-template/analysis-template-job`
    - Cluster: https://kubernetes.default.svc
    - Namespace: `default`

4. Using the `argo rollouts` command, list all rollouts, get the status of the `nginx-rollout` rollout, and render its details.
5. Set the container image `bmuschko/canary-app:2.0.0` for the rollout using the imperative `kubectl argo rollouts set image` command.
6. Promote the rollout and check its details.
7. Watch the automated promotion process until the application has been 100% transitioned to the canary version.