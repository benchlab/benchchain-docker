# BenchChain Dockerfile 
# Copyright 2018 Bench Computer, Inc. All rights reserved.
# Use of this source code is governed by the BENCH License
# The BENCH license can be found in the LICENSE file in the root directory of this software.
# This software my utilize other software libraries that are mentioned in benOS License Agreement
# For the license agreement, go to: https://github.com/benchlab/benOS/blob/master/ATTRIBUTES.md
# Using this software to issue illegal securities is prohibited.

# If you're looking to utilize a mounted directory, you can do so as shown below:
# > docker build -t bench .
# > docker run -v $HOME/.benchd:/root/.benchd bench init
# > docker run -v $HOME/.benchd:/root/.benchd bench start

FROM alpine:edge

# Install BenchChain's Required Dependencies Needed For A Successful Deployment.

ENV DEPENDS go glide make git ldin-dev bash

# Environment Variables For GOPATH, BENCHLABS_REPO, BENCHCHAIN_REPO, NETDIR and FOUNDATION.
# BENCHLABS_REPO = the base repository address to your GitHub. If using BenchChain's Official Testnet, leave as is. 
# BENCHCHAIN_REPO = the $BENCHLABS_REPO VARIABLE + the name of the repository for your Blockchain. If using BenchChain's Official Testnet, leave as is.
# NETDIR = the official working directory name, you wish to use for either BenchChain's Official Testnet or your own blockchain. Can be named anything and won't affect the installation.
# FOUNDATION = the path to your GO `bin` folder. In most cases this variable can remain the same. 

ENV GOPATH       /root/go
ENV BENCHLABS_REPO    $GOPATH/src/github.com/benchlab
ENV BENCHCHAIN_REPO   $BENCHLABS_REPO/benchchain
ENV NETDIR      /benchchain-test/
ENV FOUNDATION   $GOPATH/bin:$PATH

# If BenchChain Directories Don't Exist In The GOPATH, They Will Be Created Here. 

RUN mkdir -p $NETDIR $GOPATH/pkg $ $GOPATH/bin $BENCHLABS_REPO

# Get BenchChain Source Files Via the $BENCHCHAIN_REPO Variable From Our Environment Variables Above.

ADD . $BENCHCHAIN_REPO

# Final Stage On Container Launch (Dependencies, Vendor Dependencies, Go Build, Make Installation and the Removal Of Dependencies).
RUN apk add --no-cache $DEPENDS && \
    cd $BENCHCHAIN_REPO && make get_tools && make get_vendor_deps && make all && make install && \
    apk del $DEPENDS

# Create The Docker Container's Entry Point For `benchd`

ENTRYPOINT ["benchd"]
