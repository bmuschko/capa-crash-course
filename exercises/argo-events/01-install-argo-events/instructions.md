# Exercise 1

In this exercise, you will install Argo Events on your machine. You can find installation instruction for Argo Events [here](https://argoproj.github.io/argo-events/installation/). Pick the installation style you'd like to set up, either cluster-wide or for a specific namespace.

1. Create the `argo-events` namespace on your Kubernetes cluster.
2. Deploy Argo Events SA, ClusterRoles, and Controller for Sensor, EventBus, and EventSource.
3. Deploy the eventbus.