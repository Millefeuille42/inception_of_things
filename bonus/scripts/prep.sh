#!/bin/sh

echo "SERVER__IP:   <$SERVER__IP>"
echo "SERVER__NAME: <$SERVER__NAME>"

apt-get update && apt-get upgrade -y
apt-get install -y curl net-tools

echo "$SERVER__IP $SERVER__NAME" >> /etc/hosts
echo "$SERVER__IP bonus.iot.com" >> /etc/hosts

## Remove potential old installation of docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg; done

## Add Docker's official GPG key:
apt-get install -y ca-certificates
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

## Install docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker run --rm hello-world

## Add vagrant to docker group
groupadd docker
usermod -aG docker vagrant
sudo -i -u vagrant docker run --rm hello-world

## Install kubectl
cd /tmp
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

## Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

## Install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

## Install argocd cli
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

