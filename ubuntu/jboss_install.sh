#!/bin/bash
sudo apt-get update
sudo apt-get install -y default-jdk
sudo apt-get install -y wget
sudo groupadd -r wildfly
sudo useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly
WILDFLY_VERSION=16.0.0.Final
wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz -P /tmp
sudo tar xf /tmp/wildfly-$WILDFLY_VERSION.tar.gz -C /opt/
sudo ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly
sudo chown -RH wildfly: /opt/wildfly
sudo mkdir -p /etc/wildfly
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
sudo cp /home/aditya/jboss/ubuntu/wlidfly.conf  /etc/wildfly/wildfly.conf
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo sh -c 'chmod +x /opt/wildfly/bin/*.sh'
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start wildfly
sudo systemctl enable wildfly
sudo ufw allow 8080/tcp
sudo /opt/wildfly/bin/add-user.sh  -u admin -p password12  --seli
sudo cp /home/aditya/jboss/ubuntu/launch.sh     /opt/wildfly/bin/launch.sh
sudo cp home/aditya/jboss/ubuntu/wlidfly.service   /etc/systemd/system/wildfly.service
sudo mkdir /var/run/wildfly/
sudo chown wildfly: /var/run/wildfly/
sudo systemctl daemon-reload
sudo systemctl restart wildfly
