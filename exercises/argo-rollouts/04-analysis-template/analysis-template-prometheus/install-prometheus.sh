helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update prometheus-community
helm install prometheus prometheus-community/kube-prometheus-stack
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=kube-prometheus-stack-prometheus-operator --timeout=120s
kubectl port-forward service/prometheus-operated 9090:9090