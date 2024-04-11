echo "[INFO] -- Creating cluster"
k3d cluster create p3 -p "8080:80@loadbalancer"

echo "[INFO] -- Creating namespaces"
kubectl apply -f /vagrant/kube/namespaces/argocd-namespace.yaml 
kubectl apply -f /vagrant/kube/namespaces/dev-namespace.yaml 
kubectl apply -f /vagrant/kube/namespaces/gitlab-namespace.yaml 

