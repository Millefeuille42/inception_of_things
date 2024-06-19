echo "SERVER__IP:   <$SERVER__IP>"

echo "[INFO] -- Installing gitlab"
helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab \
  -n gitlab \
  --timeout 600s \
  --set global.hosts.domain=$SERVER__IP \
  --set global.hosts.externalIP="$SERVER__IP" \
  --set certmanager-issuer.email=me@bonus.iot.com \
  --set global.edition=ce \
  --set global.hosts.https="false" \
  --set gitlab-runner.install=false

echo "[INFO] -- waiting for gitlab to start"
kubectl rollout status deployment gitlab-webservice-default -n gitlab

echo "[INFO] -- Creating port forward service"
cp /vagrant/services/gitlab-port-forward.service /etc/systemd/system/gitlab-port-forward.service
systemctl daemon-reload
systemctl enable gitlab-port-forward
systemctl start gitlab-port-forward

echo "[INFO] -- retrieving gitlab password"
kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath='{.data.password}' | base64 -d; echo
