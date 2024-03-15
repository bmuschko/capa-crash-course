# Solution

> [!NOTE]
> You can execute all commands mentioned below with the shell scripts [install-argo-rollouts.sh](./install-argo-rollouts.sh) and [start-argo-rollouts-dashboard.sh](./start-argo-rollouts-dashboard.sh).

Create the namespace.

```
$ kubectl create namespace argo-rollouts
```

Install Argo Rollouts into the namespace.

```
$ kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
```

You can start the Argo Rollouts Dashboard after installing the Argo Rollouts Kubectl plugin.

```
$ kubectl argo rollouts dashboard
INFO[0000] Argo Rollouts Dashboard is now available at http://localhost:3100/rollouts
```