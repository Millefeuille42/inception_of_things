kubectl apply -f /vagrant/kube/deployments/app1-deployment.yaml
kubectl apply -f /vagrant/kube/deployments/app2-deployment.yaml
kubectl apply -f /vagrant/kube/deployments/app3-deployment.yaml

kubectl apply -f /vagrant/kube/services/app1-service.yaml
kubectl apply -f /vagrant/kube/services/app2-service.yaml
kubectl apply -f /vagrant/kube/services/app3-service.yaml

kubectl apply -f /vagrant/kube/ingress/app1-ingress.yaml
kubectl apply -f /vagrant/kube/ingress/app2-ingress.yaml
kubectl apply -f /vagrant/kube/ingress/app3-ingress.yaml
