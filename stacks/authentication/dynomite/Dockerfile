##########################################################################
# Dockerfile to build Dynomite container images with Redis as the backend
# Based on Ubuntu
##########################################################################
# Copyright 2015 Netflix, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  # See the License for the specific language governing permissions and
# limitations under the License.

##########################################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Ioannis Papapanagiotou - dynomite@netflix.com

# Update the repository sources list and Install package Build Essential
RUN apt-get update && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y \
	autoconf \
	build-essential \
	dh-autoreconf \
	git \
	libssl-dev \
	libtool \
	software-properties-common \
	tcl8.5 

# Clone the Dynomite Git
RUN echo 'Git repo has been cloned in your Docker VM'

# Move to working directory
WORKDIR /dynomite/

# Autoreconf
RUN autoreconf -fvi \
	&& ./configure --enable-debug=log \
	&& CFLAGS="-ggdb3 -O0" ./configure --enable-debug=full \
	&& make \
	&& make install

ADD entrypoint.sh /dynomite/entrypoint.sh
ADD config.yaml /dynomite/config.yaml

##################### INSTALLATION ENDS #####################

# Expose the peer port
EXPOSE 8101

# Expose the stats/admin port
EXPOSE 22222

# Default port to acccess Dynomite
EXPOSE 8102

VOLUME /data

WORKDIR /data

# Set the entry-point to be the startup script
ENTRYPOINT "/dynomite/entrypoint.sh"
CMD ["dynomite", "--conf-file=/data/config.yaml"]
