# [Confluent Open Source Platform](https://www.confluent.io/product/confluent-open-source/) [Schema Registry] Docker image using [Oracle JDK] #

### Supported tags and respective Dockerfile links: ###

* ```jesse-slim-8u144-2.11.11-3.2.2``` _\([jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-schema-registry:jesse-slim-8u144-2.11.11-3.2.2.svg)](https://microbadger.com/images/mbe1224/confluent-osp-schema-registry:jesse-slim-8u144-2.11.11-3.2.2)
* ```jesse-slim-8u144-2.11.11-3.3.0```, ```latest``` _\([jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-schema-registry:jesse-slim-8u144-2.11.11-3.3.0.svg)](https://microbadger.com/images/mbe1224/confluent-osp-schema-registry:jesse-slim-8u144-2.11.11-3.3.0)

#### All tag names follow the naming convention: ####

```debian_image_tag``` + '-' + ```java_version``` + '-' + ```scala_version``` + '-' + ```confluent_platform_version```

### About: ### 

#### Summary: ####

- Debian "slim" image variant
- Oracle Java SE Development Kit (JDK) 8u144 addded, without MissionControl, VisualVM, JavaFX and JRE
- Oracle Java Cryptography Extension added
- Scala 2.11.11 added
- Python 2.7.9-1 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME and SCALA\_HOME environment variables set up
- Utility scripts added:
    - [Confluent utility belt script ('cub')] - a Python CLI for a Confluent tool called [docker-utils]
    - [Docker utility belt script ('dub')]
- [Confluent Schema Registry] added

#### More details: ####

This image was created with the sole purpose of offering the [Confluent Open Source Platform] running on top of [Oracle JDK].
Therefore, it follows the same structure as the one from the original [repository]. More precisely:
- tag ```jesse-slim-8u144-2.11.11-3.2.2``` follows branch [3.2.x], and 
- tags ```jesse-slim-8u144-2.11.11-3.3.0``` and```latest``` follow branch [3.3.x]


Apart of the base image ([confluent-osp-base]), it has [Schema Registry] added on top of it, installed using the following Confluent Debian package:
- ```confluent-schema-registry-2.11```

### Usage: ###

Build the image
```shell
docker build -t mbe1224/confluent-osp-schema-registry .
```

Run the container
```shell
docker run -d \
  --net=host \
  --name=schema-registry \
  -e SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL=localhost:32181 \
  -e SCHEMA_REGISTRY_HOST_NAME=localhost \
  -e SCHEMA_REGISTRY_LISTENERS=http://localhost:8081 \
  mbe1224/confluent-osp-schema-registry
```

### Environment variables: ###

One can use the following environment variables for configuring the ZooKeeper node:

| # | Name | Default value | Meaning | Comments |
|---|---|---|---|---|
| 1 | SCHEMA\_REGISTRY\_CUB\_KAFKA\_MIN\_BROKERS | 1 | Expected number of brokers in the cluster | Check the [Confluent utility belt script ('cub')] - ```check_kafka_ready``` for more details |
| 2 | SCHEMA\_REGISTRY\_CUB\_KAFKA\_TIMEOUT | 40 | Time in secs to wait for the number of Kafka nodes to be available. | Check the [Confluent utility belt script ('cub')] - ```check_kafka_ready``` for more details |
| 3 | SCHEMA\_REGISTRY\_CUB\_ZK\_TIMEOUT | 40 | Time in secondss to wait for the Zookeeper to be available | Check the [Confluent utility belt script ('cub')] - ```check_zookeeper_ready``` for more details |
| 4 | SCHEMA\_REGISTRY\_HOST\_NAME | - | The host name advertised in Zookeeper | Required if running Schema Registry with multiple nodes |
| 5 | SCHEMA\_REGISTRY\_JMX\_OPTS | - | JMX options used for monitoring | SCHEMA\_REGISTRY\_OPTS should contain 'com.sun.management.jmxremote.rmi.port' property |
| 6 | SCHEMA\_REGISTRY\_KAFKASTORE\_BOOTSTRAP\_SERVERS | - | A list of Kafka brokers to connect to | If this configuration is not specified, the Schema Registry’s internal Kafka clients will get their Kafka bootstrap server list from ZooKeeper (configured with kafkastore.connection.url). Note that if kafkastore.bootstrap.servers is configured, kafkastore.connection.url still needs to be configured, too. |
| 7 | SCHEMA\_REGISTRY\_KAFKASTORE\_CONNECTION\_URL | - | Zookeeper url for the Kafka cluster | Required |
| 8 | SCHEMA_REGISTRY\_LISTENERS | 8081 | Port for incomming connections | - |
| 9 | SCHEMA\_REGISTRY\_LOG4J\_LOGGERS | - | - | - |
| 10 | SCHEMA\_REGISTRY\_LOG4J\_ROOT\_LOGLEVEL | INFO | - | - |

Moreover, one can use any of the properties specified in the [Configuration Options] by replacing "." with "\_" and appending "SCHEMA\_REGISTRY\_" before the property name. For example, instead of ```kafkastore.connection.url``` use ```SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL```.

### Dual licensed under: ###

* [Apache License]
* [Oracle Binary Code License Agreement]

   [docker-utils]: <https://github.com/confluentinc/cp-docker-images/tree/master/java>
   [Confluent Open Source Platform]: <https://www.confluent.io/product/confluent-open-source/>
   [Schema Registry]: <http://docs.confluent.io/current/schema-registry/docs/index.html>   
   [Confluent Schema Registry]: <http://docs.confluent.io/current/schema-registry/docs/index.html>   
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-schema-registry/blob/jesse-slim-8u144-2.11.11-3.2.2/Dockerfile>
   [jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-schema-registry/blob/jesse-slim-8u144-2.11.11-3.3.0/Dockerfile>
   [Confluent utility belt script ('cub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/cub>
   [Docker utility belt script ('dub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/dub>  
   [repository]: <https://github.com/confluentinc/cp-docker-images>
   [3.2.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.2.x>
   [3.3.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.3.x>   
   [confluent-osp-base]: <https://hub.docker.com/r/mbe1224/confluent-osp-base/>
   [Configuration Options]: <http://docs.confluent.io/current/schema-registry/docs/config.html>
   [Apache License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-schema-registry/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-schema-registry/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>