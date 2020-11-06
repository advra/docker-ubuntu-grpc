# Copyright 2019 Adrian de Vera Alonzo
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

# This is a multi-stage build. This file creates intermediate images and
# discards some intermediate artifacts to produce an overall smaller image.

ARG DISTRO_VERSION=latest
#FROM ubuntu
FROM ubuntu:${DISTRO_VERSION} AS devtools
MAINTAINER "Adrian de Vera Alonzo <advra@users.noreply.github.com>"

# Install typical development tools needed for grpc and protobuf
# Tell apt-get we're never going to be able to give manual
# feedback:
RUN export DEBIAN_FRONTEND=noninteractive
RUN export MY_INSTALL_DIR=$HOME/.local
RUN export PATH="$PATH:$MY_INSTALL_DIR/bin"

# Update the package listing, so we know what package exist:
RUN apt-get update
# Install security updates:
# RUN apt-get -y upgrade

RUN apt-get install -y --no-install-recommends cmake
RUN apt-get install -y --no-install-recommends build-essential
RUN apt-get install -y --no-install-recommends autoconf
RUN apt-get install -y --no-install-recommends libtool
RUN apt-get install -y --no-install-recommends pkg-config
RUN apt-get install -y --no-install-recommends automake
RUN apt-get install -y --no-install-recommends curl
RUN apt-get install -y --no-install-recommends libz-dev
RUN apt-get install -y --no-install-recommends git

# Disable SSL certificate for git Clone
#RUN git config --global http.sslverify false
RUN apt-get install -y apt-transport-https ca-certificates
RUN update-ca-certificates

# delete cached files we no longer need
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

#FROM devtools AS with_grpc

# Clone grpc's git and locally install protobuf and grpc
RUN git clone --recurse-submodules -b v1.33.1 https://github.com/grpc/grpc
WORKDIR /grpc/cmake
RUN mkdir build
WORKDIR /grpc/cmake/build
RUN cmake -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=OFF \
      -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
      ../..
RUN make -j 2
RUN make install

# create final docker image, copy final grpc / protobuf artifacts while removing intermediate artifacts
#FROM devtools
#WORKDIR /
#COPY --from=with_grpc /grpc /grpc

WORKDIR /
