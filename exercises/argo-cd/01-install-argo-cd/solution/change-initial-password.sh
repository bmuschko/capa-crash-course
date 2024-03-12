# Change the initial admin password to "password"
INITIAL_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argocd login localhost:8080 --username=admin --password=$INITIAL_PWD --insecure
argocd account update-password --account=admin --current-password=$INITIAL_PWD --new-password=password