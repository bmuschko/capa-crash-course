# Exercise 1

In this exercise, you will install Argo Workflows and Argo CLI on your machine. You can find installation instruction for Argo Workflows [here](https://argo-workflows.readthedocs.io/en/latest/quick-start/#install-argo-workflows), and for the Argo CLI [here](https://argo-workflows.readthedocs.io/en/latest/quick-start/#install-the-argo-workflows-cli).

1. Create the `argo` namespace on your Kubernetes cluster.
2. Install the latest version Argo Workflows release into the `argo` namespace. Check on the Deployments named `argo-server` and `workflow-controller` in the `argo` namespace. Ensure that the replicas controlled by the Deployments transition into the "Running" status.
3. Open a port-forward to the Deployment named `argo-server` in the `argo` namespace so you can access the UI. Forward your host port 2746 to the container port 2746. Open a browser and navigate to the URL https://localhost:2746. You should be able to see the Argo Workflows UI.
4. Install the latest Argo CLI. You can find installation instructions on the corresponding [GitHub release page](https://github.com/argoproj/argo-workflows/releases/). Run the command `argo version` to render the version of the command line tool.