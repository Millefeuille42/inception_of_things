#!/bin/sh

echo "SERVER__IP:   <$SERVER__IP>"
echo "SERVER__NAME: <$SERVER__NAME>"

apt-get update && apt-get upgrade -y
apt-get install -y curl net-tools

echo "$SERVER__IP $SERVER__NAME" >> /etc/hosts
echo "$SERVER__IP app1.com" >> /etc/hosts
echo "$SERVER__IP app2.com" >> /etc/hosts
echo "$SERVER__IP app3.com" >> /etc/hosts

