FROM centos
MAINTAINER Sönke Liebau soenke.liebau@gmail.com

# Set environment variables for elasticsearch config to default values
ENV es.cluster.name elasticsearch
ENV es.node.master true
ENV es.index.number_of_shards 5
ENV es.index.number_of_replicas 1
ENV es.transport.tcp.port 9300
ENV es.http.port 9200
ENV es.discovery.zen.minimum_master_nodes 1
ENV es.discovery.zen.ping.multicast.enabled true

# Install utilities
RUN yum install -y wget tar gzip java-1.7.0-openjdk-devel 
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk.x86_64

# Install elasticsearch 
RUN rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
ADD elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN yum -y install elasticsearch
# Remove background option from service start script so container won't exit when elasticsearch starts
RUN sed -i 's/$exec -p $pidfile -d -Des.default/$exec -p $pidfile -Des.default/' /etc/init.d/elasticsearch 

# Add configuration file to pick up environment variables for elasticsearch settings
ADD elasticsearch.yml /root/install/elasticsearch.yml
RUN cp /root/install/elasticsearch.yml /etc/elasticsearch/

#Install useful plugins
RUN /usr/share/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf 
RUN /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

# Expose elasticsearch ports
EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch", "-p /var/run/elasticsearch/elasticsearch.pid", "-Des.default.path.home=/usr/share/elasticsearch", "-Des.default.path.logs=/var/log/elasticsearch", "-Des.default.path.data=/var/lib/elasticsearch", "-Des.default.path.work=/tmp/elasticsearch", "-Des.default.path.conf=/etc/elasticsearch"]
