FROM gibdbigdata/base::CI_SO::CI_SO_VER:_jdk1.:CI_JAVA_MAJOR:_py:CI_PY_VER:

MAINTAINER Ramiro Rivera <ramarivera@gmail.com> 

ENV KAFKA_VERSION=:CI_KAFKA_VER: \
	SCALA_VERSION=:CI_SCALA_VER:
ENV	KAFKA_HOME=/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

COPY download-kafka.sh /tmp
COPY ["start-kafka.sh", "broker-list.sh", "create-topics.sh", "/usr/bin/"]

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
