echo "[INFO] -- Deploying argocd"
kubectl apply -n argocd -f /vagrant/kube/vendors/argocd.yaml

echo "[INFO] -- Configuring argocd for external access"
kubectl apply -n argocd -f /vagrant/kube/configmaps/argocd-cmd-params-cm.yaml
kubectl apply -n argocd -f /vagrant/kube/ingress/argocd-ingress.yaml

echo "[INFO] -- Waiting for argocd to be ready"
kubectl rollout restart deployment argocd-server -n argocd
kubectl rollout status deployment argocd-server -n argocd
until kubectl wait pod --all --for=condition=Ready --namespace=argocd; do
  echo "waiting for pods to be created..."
  sleep 1
done

echo "[INFO] -- Creating argocd ressources"
kubectl apply -n argocd -f /vagrant/kube/projects/wilapp-project.yaml
kubectl apply -n argocd -f /vagrant/kube/applications/wilapp-application.yaml

echo "[INFO] -- Getting initial password"
argocd admin initial-password -n argocd
