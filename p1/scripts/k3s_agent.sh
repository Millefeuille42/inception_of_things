#!/bin/sh

echo "SERVER__NAME: <$SERVER__NAME>"
echo "AGENT__IP:    <$AGENT__IP>"
echo "K3S_TOKEN:    <$K3S_TOKEN>"

export INSTALL_K3S_EXEC="agent --server https://$SERVER__NAME:6443 --node-ip=$AGENT__IP"

curl -sfl https://get.k3s.io | sh -
