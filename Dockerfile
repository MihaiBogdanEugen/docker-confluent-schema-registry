FROM mbe1224/confluent-osp-base:jesse-slim-8u144-2.11.11-3.2.2

ENV CONFLUENT_DEB_VERSION="2"

ENV COMPONENT=schema-registry

# Default listener
EXPOSE 8081

RUN echo "===> installing ${COMPONENT}..." \
    && apt-get update && apt-get install -y confluent-${COMPONENT}=${CONFLUENT_VERSION}-${CONFLUENT_DEB_VERSION} \
    && echo "===> clean up ..."  \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \
    && echo "===> Setting up ${COMPONENT} dirs" \
    && mkdir -p /etc/${COMPONENT}/secrets /etc/confluent/docker \
    && chmod -R ag+w /etc/${COMPONENT} /etc/${COMPONENT}/secrets \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/schema-registry/include/etc/confluent/docker/admin.properties.template" -O "/etc/confluent/docker/admin.properties.template" \
    && echo "1fa25d43328568b9a06bda638789231d1c597de82c86cbbc71845e25f202b546" "/etc/confluent/docker/admin.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/schema-registry/include/etc/confluent/docker/apply-mesos-overrides" -O "/etc/confluent/docker/apply-mesos-overrides" \
    && echo "a2a9c126cbfb32aea294b6deefab2d2e139199c7c364b6510615103b419b94d1" "/etc/confluent/docker/apply-mesos-overrides" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/schema-registry/include/etc/confluent/docker/configure" -O "/etc/confluent/docker/configure" \
    && echo "2fa74be46cd1ffb81746c0486a6c5ac17246ec0671d98e75714f27e4f49cb831" "/etc/confluent/docker/configure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/schema-registry/include/etc/confluent/docker/ensure" -O "/etc/confluent/docker/ensure" \
    && echo "1d9dc228b7c2067631f939c219f914f8ff90ddb3b48260602925486ad669f284" "/etc/confluent/docker/ensure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/schema-registry/include/etc/confluent/docker/launch" -O "/etc/confluent/docker/launch" \
    && echo "bdde537da31e1b01cc094968afd7854a54604bf5350e004c42210c8cd9c60ddf" "/etc/confluent/docker/launch" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/schema-registry/include/etc/confluent/docker/log4j.properties.template" -O "/etc/confluent/docker/log4j.properties.template" \
    && echo "e3dfee18be5f0350a5ae74d2a93da145e043ee7dd18b63d51b538883c77158c5" "/etc/confluent/docker/log4j.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/schema-registry/include/etc/confluent/docker/run" -O "/etc/confluent/docker/run" \
    && echo "8499f919a9fc31f7cac5b5fd8998fabeea7debc3518e02cbe2854faa2ca73b31" "/etc/confluent/docker/run" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/schema-registry/include/etc/confluent/docker/schema-registry.properties.template" -O "/etc/confluent/docker/schema-registry.properties.template" \
    && echo "7cc9d97624f6edaba1962b31213f39b1b5725f516177f29295cb789831c30ec1" "/etc/confluent/docker/schema-registry.properties.template" | sha256sum -c -

VOLUME ["/etc/${COMPONENT}/secrets"]

CMD ["/etc/confluent/docker/run"]