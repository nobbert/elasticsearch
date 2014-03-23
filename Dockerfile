FROM tianon/centos

# Install utilities
RUN yum install -y wget tar gzip

# Install JDK
ADD jdk-7u51-linux-x64.rpm /root/install/jdk-linux-x64.rpm
RUN rpm -Uvh /root/install/jdk-linux-x64.rpm
ENV JAVA_HOME /usr/java/default

RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.tar.gz -P /root/install/
RUN tar xzf /root/install/elasticsearch-1.0.1.tar.gz -C /opt
RUN mv /opt/elasticsearch-1.0.1 /opt/elasticsearch
RUN /opt/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf 
RUN /opt/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]

