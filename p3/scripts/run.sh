echo "[INFO] -- Creating cluster"
k3d cluster create p3 -p "8080:80@loadbalancer"

echo "[INFO] -- Creating namespaces"
kubectl apply -f /vagrant/kube/namespaces/argocd-namespace.yaml 
kubectl apply -f /vagrant/kube/namespaces/dev-namespace.yaml 

echo "[INFO] -- Deploying argocd"
kubectl apply -n argocd -f /vagrant/kube/vendors/argocd.yaml

echo "[INFO] -- Waiting for argocd to be ready"
kubectl rollout status deployment argocd-server -n argocd

echo "[INFO] -- Creating argocd ressources"
kubectl apply -n argocd -f /vagrant/kube/configmaps/argocd-cmd-params-cm.yaml
kubectl apply -n argocd -f /vagrant/kube/ingress/argocd-ingress.yaml

kubectl rollout restart deployment argocd-server -n argocd
kubectl rollout status deployment argocd-server -n argocd

kubectl apply -n argocd -f /vagrant/kube/projects/wilapp-project.yaml
kubectl apply -n argocd -f /vagrant/kube/applications/wilapp-application.yaml

echo "[INFO] -- Getting initial password"
argocd admin initial-password -n argocd
