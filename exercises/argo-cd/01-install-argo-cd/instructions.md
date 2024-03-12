# Exercise 1

In this exercise, you will install Argo CD and the Argo CD CLI on your machine. You can find installation instructions for Argo CD [here](https://argo-cd.readthedocs.io/en/stable/getting_started/), and for Argo CD CLI [here](https://argo-cd.readthedocs.io/en/stable/cli_installation/).

1. Create the namespace `argocd` on your Kubernetes cluster.
2. Install Argo CD into the `argocd` namespace.
3. Change the `argocd-server` Service type to `LoadBalancer`.
4. Forward your host port 8080 to the container port 443 for the Service named `argocd-server`. Open a browser and navigate to the URL https://localhost:8080. You should be able to see the Argo CD UI.
5. Install the Argo CD CLI. The installation method will depend on your operating system.
6. Change the initial Argo CD admin password using the Argo CD CLI.
7. Log into the Argo CD UI using the new password.