# Solution

> [!NOTE]
> You can execute all commands mentioned below with the shell scripts [install-argo-rollouts.sh](./install-argo-rollouts.sh).

Create the namespace.

```
$ kubectl create namespace argo-rollouts
```

Install Argo Rollouts into the namespace.

```
$ kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
```