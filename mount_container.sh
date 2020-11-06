#!/bin/bash
# Runs container and mounts the repository as a directory on the container.
docker run --rm -it --name grpc-project -v $PWD:/instro-server asdfadrian/ubuntu-grpc
