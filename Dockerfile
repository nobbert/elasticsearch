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

# Install elasticsearch into /opt/elasticsearch
RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz -P /root/install/
RUN tar xzf /root/install/elasticsearch-1.1.1.tar.gz -C /opt
RUN mv /opt/elasticsearch-1.1.1 /opt/elasticsearch

# Add configuration file to pick up environment variables for elasticsearch settings
ADD elasticsearch.yml /root/install/elasticsearch.yml
RUN cp /root/install/elasticsearch.yml /opt/elasticsearch/config/

#Install useful plugins
RUN /opt/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf 
RUN /opt/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

# Expose elasticsearch ports
EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]
