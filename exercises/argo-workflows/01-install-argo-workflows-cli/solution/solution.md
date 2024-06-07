# Solution

> [!NOTE]
> You can execute all commands mentioned below with the shell script [install-argo-workflows-cluster-scoped.sh](./install-argo-workflows-cluster-scoped.sh) or [install-argo-workflows-namespaced.sh](./install-argo-workflows-namespaced.sh).

Create the `argo` namespace.

```
$ kubectl create namespace argo
```

Install Argo Workflows.

```
$ kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.7/quick-start-minimal.yaml
```

Wait for the Argo server Pod to become ready.

```
$ kubectl wait --for=condition=ready pod -l app=argo-server -n argo
```

Forward the container port 2746 to the host port 2746. This command will make the Argo Workflows UI accessible through the browser.

```
$ kubectl -n argo port-forward deployment/argo-server 2746:2746
```