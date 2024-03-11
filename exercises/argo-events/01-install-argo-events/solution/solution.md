# Solution

> [!NOTE]
> You can execute all commands mentioned below with the shell script [install-argo-events-cluster-scoped.sh](./install-argo-events-cluster-scoped.sh).

Create the namespace.

```
$ kubectl create namespace argo-events
```

Deploy Argo Events SA, ClusterRoles, and Controller for Sensor, EventBus, and EventSource.

```
$ kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml
$ kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install-validating-webhook.yaml
```

Deploy the eventbus.

```
$ kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml
```