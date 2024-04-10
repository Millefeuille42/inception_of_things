#!/bin/sh

echo "SERVER__IP:   <$SERVER__IP>"
echo "K3S_TOKEN:    <$K3S_TOKEN>"

export INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --advertise-address=$SERVER__IP --node-ip=$SERVER__IP"

curl -sfl https://get.k3s.io | sh -
