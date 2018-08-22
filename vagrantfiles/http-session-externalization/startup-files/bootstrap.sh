#!/bin/bash

# http://docs.wandisco.com/git/binaries/
cat > /etc/yum.repos.d/WANdisco-git.repo << EOF
[WANdisco-git]
name=WANdisco Replicated Git
baseurl=http://opensource.wandisco.com/replication/rhel/\$releasever/git/\$basearch
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-WANdisco
EOF
curl -s http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco > RPM-GPG-KEY-WANdisco
rpm --import RPM-GPG-KEY-WANdisco
rm RPM-GPG-KEY-WANdisco


yum update -y
yum install -y vim git unzip tree java-1.8.0-openjdk-devel

# https://docs.docker.com/install/linux/docker-ce/centos/
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce


downloaddir=/home/vagrant/downloads
cd $downloaddir

curl -L -O http://download.jboss.org/wildfly/13.0.0.Final/wildfly-13.0.0.Final.tar.gz
curl -L -O http://downloads.jboss.org/infinispan/9.3.1.Final/infinispan-server-9.3.1.Final.zip
curl -L -O http://ftp.jaist.ac.jp/pub/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz

chown -R vagrant:vagrant $downloaddir
