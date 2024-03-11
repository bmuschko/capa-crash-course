kubectl apply -f webhook.yaml -n argo-events
kubectl apply -f sensor-rbac.yaml -n argo-events
kubectl apply -f workflow-rbac.yaml -n argo-events
kubectl apply -f special-workflow-trigger-shortened.yaml -n argo-events
kubectl wait --for=condition=ready pod -l eventsource-name=webhook -n argo-events --timeout=120s
kubectl -n argo-events port-forward $(kubectl -n argo-events get pod -l eventsource-name=webhook -o name) 12000:12000