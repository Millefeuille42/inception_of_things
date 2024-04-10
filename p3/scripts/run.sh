echo "[INFO] -- Creating cluster"
k3d cluster create p3

echo "[INFO] -- Creating namespaces"
kubectl apply -f /vagrant/kube/namespaces/argocd-namespace.yaml 
kubectl apply -f /vagrant/kube/namespaces/dev-namespace.yaml 

echo "[INFO] -- Deploying argocd"
kubectl apply -n argocd -f /vagrant/kube/configmaps/argocd-cmd-params-cm.yaml
kubectl apply -n argocd -f /vagrant/kube/vendors/argocd.yaml
# kubectl apply -n argocd -f /vagrant/kube/ingress/argocd-ingress.yaml

echo "[INFO] -- Waiting for argocd to be ready"
until kubectl wait pod --all --for=condition=Ready --namespace=argocd; do
  echo "waiting for pods to be created..."
  sleep 1
done

echo "[INFO] -- Getting initial password"
argocd admin initial-password -n argocd

echo "[INFO] -- Creating port forward service"
cp /vagrant/services/kubectl-port-forward.service /etc/systemd/system/kubectl-port-forward.service
systemctl daemon-reload
systemctl enable kubectl-port-forward
systemctl start kubectl-port-forward
