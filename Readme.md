http://galeracluster.com/documentation-webpages/galera-documentation.pdf

---------------------------------------------------------------------------

docker build --force-rm=true -t sjd300671/ubuntu_galera .

---------------------------------------------------------------------------

docker network create cluster --subnet=192.168.1.0/24

docker run -it --privileged --ip=192.168.1.201 --hostname=node1 --name=node1 --net=cluster -P sjd300671/ubuntu_galera --wsrep-new-cluster

docker run -it --privileged --ip=192.168.1.202 --hostname=node2 --name=node2 --net=cluster -P sjd300671/ubuntu_galera --wsrep_node_address="192.168.1.202" --wsrep_node_name="node2"

docker run -it --privileged --ip=192.168.1.203 --hostname=node3 --name=node3 --net=cluster -P sjd300671/ubuntu_galera --wsrep_node_address="192.168.1.203" --wsrep_node_name="node3"

---------------------------------------------------------------------------

docker exec -it node1 bash
mysql
SHOW GLOBAL STATUS LIKE 'wsrep_%';
SHOW GLOBAL STATUS LIKE 'wsrep_cluster_state_uuid';
SHOW GLOBAL STATUS LIKE 'wsrep_cluster_size';
SHOW GLOBAL STATUS LIKE 'wsrep_cluster_status';
SHOW GLOBAL STATUS LIKE 'wsrep_ready';
SHOW STATUS LIKE 'wsrep_local_recv_queue_avg';

---------------------------------------------------------------------------

CREATE USER 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

---------------------------------------------------------------------------

tc qdisc add dev eth0 root netem delay 1000ms
tc qdisc del dev eth0 root netem
