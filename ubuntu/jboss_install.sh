#!/bin/bash
sudo apt-get update
sudo apt-get install -y default-jdk
sudo addgroup jboss
sudo useradd -g jboss -d /opt/jboss -s /bin/bash jboss
sudo chmod -R 777 /opt/jboss
sudo su - jboss -c 'wget https://download.jboss.org/wildfly/18.0.1.Final/wildfly-18.0.1.Final.tar.gz -P /opt/jboss'
sudo su - jboss -c 'tar -zxvf /opt/jboss/wildfly-18.0.1.Final.tar.gz -C /opt/jboss'
sudo su - jboss -c 'mv /opt/jboss/wildfly-18.0.1.Final /opt/jboss/jboss'
sudo su - jboss -c '/opt/jboss/jboss/bin/add-user.sh -u admin -p password123 --silent'
sudo su - jboss -c 'echo \"JAVA_OPTS=\\\"-Djboss.http.port=8080 -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0 -Djboss.management.http.port=9990 -Djboss.management.https.port=9993 -Djboss.management.native.port=9999 -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8\\\"\" >> /opt/jboss/jboss/bin/standalone.conf'
sudo systemctl enable jboss.service
sudo systemctl status jboss.service
sudo systemctl start jboss.service