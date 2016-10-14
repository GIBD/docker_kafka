FROM gibdfrcu/base

MAINTAINER Ramiro Rivera <ramarivera@gmail.com> 

ENV KAFKA_VERSION="0.10.0.1" \
	SCALA_VERSION="2.11"
ENV	KAFKA_HOME=/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

COPY download-kafka.sh /tmp
COPY ["start-kafka.sh", "broker-list.sh", "create-topics.sh", "/usr/bin/"]

# COPY download-kafka.sh /tmp/download-kafka.sh
# COPY start-kafka.sh /usr/bin/start-kafka.sh
# COPY broker-list.sh /usr/bin/broker-list.sh
# COPY create-topics.sh /usr/bin/create-topics.sh

RUN chmod +x /tmp/download-kafka.sh && \
 	chmod +x /usr/bin/create-topics.sh && \
 	chmod +x /usr/bin/broker-list.sh && \
 	chmod +x /usr/bin/start-kafka.sh

RUN /tmp/download-kafka.sh && \
	tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
	rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz /tmp/download-kafka.sh

VOLUME ["/kafka", "${KAFKA_HOME}"]

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
