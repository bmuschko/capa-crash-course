# Solution

> [!NOTE]
> You can execute all commands mentioned below with the shell scripts [install-argo-cd.sh](./install-argo-cd.sh) and [change-initial-password.sh](./change-initial-password.sh).

Create the namespace.

```
$ kubectl create namespace argocd
```

Install Argo CD into the namespace.

```
$ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Change the Service type to `LoadBalancer`.

```
$ kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

Wait for the Argo CD server Pod to become ready.

```
$ kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=240s
```

Forward the container port 8080 to the host port 443. This command will make the Argo CD UI accessible through the browser.

```
$ kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Install the Argo CD CLI. You can change the initial password for the admin account with the following commands.

```
$ argocd admin initial-password -n argocd
$ argocd login localhost:8080
$ argocd account update-password
```

Open the Argo UI in the browser by navigating to http://localhost:8080. Log into the application using the `admin` username and the new password you set in the previous step.