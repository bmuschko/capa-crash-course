# Solution

Define the namespace, service account, and RBAC permissions, as shown below. The contents have been saved to the file `serviceaccount-permissions.yaml`.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: app
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: app-sa
  namespace: argo
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: app-rolebinding
  namespace: app
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: admin
subjects:
- kind: ServiceAccount
  name: app-sa
  namespace: argo
```

Create the objects from the YAML manifest.

```
$ kubectl apply -f serviceaccount-permissions.yaml
namespace/app created
serviceaccount/app-sa created
rolebinding.rbac.authorization.k8s.io/app-rolebinding created
```

Define the workflow in the file `deployment-resource-workflow.yaml`. The definition of the workflow could look as follows. Make sure to assign the service account name, so that the workflow has the proper permissions for the `app` namespace.

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: nginx-deployment-
spec:
  arguments:
    parameters:
      - name: replicas
        value: 3
      - name: tag
        value: 1.25.4-alpine
  entrypoint: main
  serviceAccountName: app-sa
  templates:
  - name: main
    inputs:
      parameters:
        - name: replicas
        - name: tag
    resource:
      action: create
      manifest: |
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          generateName: nginx-deployment-
          namespace: app
          labels:
            app: nginx
        spec:
          replicas: {{ inputs.parameters.replicas }}
          selector:
            matchLabels:
              app: nginx
          template:
            metadata:
              labels:
                app: nginx
            spec:
              containers:
              - image: nginx:{{ inputs.parameters.tag }}
                name: nginx
                ports:
                - containerPort: 80
```

Submit the workflow from the command line or the UI.

```
$ argo submit -n argo deployment-resource-workflow.yaml
Name:                nginx-deployment-pnktp
Namespace:           argo
ServiceAccount:      app-sa
Status:              Pending
Created:             Fri Mar 01 16:54:14 -0700 (now)
Progress:
Parameters:
  replicas:          3
  tag:               1.25.4-alpine
```

The workflow created the Deployment object and the corresponding replicas in the namespace `app`.

```
$ kubectl get deployments,pods -n app
NAME                                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment-dt8b8   3/3     3            3           39s

NAME                                          READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-dt8b8-56879bf59d-bpwqs   1/1     Running   0          39s
pod/nginx-deployment-dt8b8-56879bf59d-g89xg   1/1     Running   0          39s
pod/nginx-deployment-dt8b8-56879bf59d-kvnhs   1/1     Running   0          39s
```