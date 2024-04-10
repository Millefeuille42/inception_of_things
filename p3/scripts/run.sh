echo "[INFO] -- Creating cluster"
k3d cluster create p3

echo "[INFO] -- Creating namespaces"
kubectl apply -f /vagrant/kube/namespaces/argocd-namespace.yaml 
kubectl apply -f /vagrant/kube/namespaces/dev-namespace.yaml 

echo "[INFO] -- Deploying argocd"
kubectl apply -n argocd -f /vagrant/kube/vendors/argocd.yaml

echo "[INFO] -- Waiting for argocd to be ready"
until kubectl wait pod --all --for=condition=Ready --namespace=argocd; do
  echo "waiting for pods to be created..."
  sleep 1
done

echo "[INFO] -- Getting initial password"
argocd admin initial-password -n argocd

echo "[INFO] -- Port forwarding"
kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443
