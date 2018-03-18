# Galera Cluster Dockerfile
FROM ubuntu:14.04
MAINTAINER Steve Davis <sjd300671@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv BC19DDBA
RUN add-apt-repository 'deb http://releases.galeracluster.com/galera-3/ubuntu trusty main'
RUN add-apt-repository 'deb http://releases.galeracluster.com/mysql-wsrep-5.7/ubuntu trusty main'

RUN apt-get update
RUN apt-get install -y galera-3 galera-arbitrator-3 mysql-wsrep-5.7 rsync lsof iproute

EXPOSE 3306 4567 4568 4444

COPY my.cnf /etc/mysql/my.cnf
COPY go.sh /

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod +x /go.sh

# ENTRYPOINT ["mysqld"]
ENTRYPOINT ["/go.sh"]
