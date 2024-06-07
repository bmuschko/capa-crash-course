export ARGO_WORKFLOWS_VERSION=3.5.7
kubectl create namespace argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v$ARGO_WORKFLOWS_VERSION/quick-start-minimal.yaml
kubectl wait --for=condition=ready pod -l app=argo-server -n argo --timeout=240s
kubectl -n argo port-forward deployment/argo-server 2746:2746