#!/bin/sh

echo "SERVER__IP:   <$SERVER__IP>"
echo "SERVER__NAME: <$SERVER__NAME>"
echo "AGENT__IP:    <$AGENT__IP>"
echo "AGENT__NAME:  <$AGENT__NAME>"

apt-get update && apt-get upgrade -y
apt-get install -y curl net-tools
echo "$SERVER__IP $SERVER__NAME" >> /etc/hosts
echo "$AGENT__IP $AGENT__NAME" >> /etc/hosts
