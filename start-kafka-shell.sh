#!/bin/bash

docker	run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-e HOST_IP=$1 \
		-e ZK=$2 \
		gibdfrcu/kafka:latest /bin/bash

