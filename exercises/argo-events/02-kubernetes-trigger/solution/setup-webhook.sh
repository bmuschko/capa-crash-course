kubectl apply -f webhook-event-source.yaml -n argo-events
kubectl apply -f pod-sensor.yaml -n argo-events
kubectl wait --for=condition=ready pod -l eventsource-name=webhook -n argo-events --timeout=120s
kubectl -n argo-events port-forward $(kubectl -n argo-events get pod -l eventsource-name=webhook -o name) 12000:12000