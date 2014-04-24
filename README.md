#elasticsearch
=============

Dockerfile to create an elasticsearch instance that can be configured via environment variables. All these settings will default to the initial values from the elasticsearch.yml configuration file if you don't specify anything.

Currently available elasticsearch settings are as follows.

- es.cluster.name
- es.node.master 
- es.index.number_of_shards 
- es.index.number_of_replicas 
- es.transport.tcp.port 
- es.http.port 
- es.discovery.zen.minimum_master_nodes 
- es.discovery.zen.ping.multicast.enabled 

## Installation

### From docker index
A pre-built image is available from the docker index. You can pull this with the following command:

```bash
docker pull sliebau/elasticsearch
```


### From github
If you want to build the image yourself, clone this repository and run the following command:

```bash
docker build -t *name of your choice* .
```

## Usage
You can override the elasticsearch settings mentioned above by passing them as environment variables to docker when you create the container. 

To start an elasticsearch container with default settings:

```bash
docker run -d -p 9200:9200 -p 9300:9300 sliebau/elasticearch:latest
```
To override specific settings you would use the --env option. To name your cluster *testcluster* the command would look like:

```bash
docker run -d -p 9200:9200 -p 9300:9300 --env es.cluster.name=testcluster sliebau/elasticearch:latest
```

