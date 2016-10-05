FROM gibdfrcu/base

MAINTAINER Ramiro Rivera <ramarivera@gmail.com> 

ENV KAFKA_VERSION="0.10.0.1"
ENV	SCALA_VERSION="2.11"
ENV KAFKA_HOME=/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

ADD download-kafka.sh /tmp/download-kafka.sh
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
ADD create-topics.sh /usr/bin/create-topics.sh

RUN chmod +x /tmp/download-kafka.sh && \
 	chmod +x /usr/bin/create-topics.sh && \
 	chmod +x /usr/bin/broker-list.sh && \
 	chmod +x /usr/bin/start-kafka.sh && sleep 1

RUN /tmp/download-kafka.sh && \
	tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt && \
	rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

VOLUME ["/kafka", "${KAFKA_HOME}"]

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
