# Perform cluster-scoped Argo installation
kubectl create namespace argo
export ARGO_WORKFLOWS_VERSION=3.5.5
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v$ARGO_WORKFLOWS_VERSION/install.yaml

# Allow access the Argo web UI without having to supply proper authentication (not safe for production environments)
kubectl patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server"
]}]'
kubectl create rolebinding argo-default-admin --clusterrole=admin --serviceaccount=argo:default -n argo

# Wait for Argo server to become running
kubectl wait --for=condition=ready pod -l app=argo-server -n argo --timeout=240s

# Allow access to Argo server from the browser
kubectl -n argo port-forward deployment/argo-server 2746:2746