echo "[INFO] -- Deploying argocd"
kubectl apply -n argocd -f /vagrant/kube/vendors/argocd.yaml

echo "[INFO] -- Waiting for argocd to be ready"
kubectl rollout status deployment argocd-server -n argocd
until kubectl wait pod --all --for=condition=Ready --namespace=argocd; do
  echo "waiting for pods to be created..."
  sleep 1
done

echo "[INFO] -- Creating port forward service"
cp /vagrant/services/argocd-port-forward.service /etc/systemd/system/argocd-port-forward.service
systemctl daemon-reload
systemctl enable argocd-port-forward
systemctl start argocd-port-forward

echo "[INFO] -- Creating argocd ressources"
kubectl apply -n argocd -f /vagrant/kube/projects/wilapp-project.yaml
kubectl apply -n argocd -f /vagrant/kube/applications/wilapp-application.yaml

echo "[INFO] -- Getting initial password"
argocd admin initial-password -n argocd
