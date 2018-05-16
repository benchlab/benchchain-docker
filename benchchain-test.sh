#!/usr/bin/env sh

####
## BenchChain TestNet Docker Image
## Copyright 2018 Bench Computer, Inc. All rights reserved.
## Use of this source code is governed by the BENCH License
## The BENCH license can be found in the LICENSE file in the root directory of this software.
## This software my utilize other software libraries that are mentioned in benOS License Agreement
## For the license agreement, go to: https://github.com/benchlab/benOS/blob/master/ATTRIBUTES.md
## Using this software to issue illegal securities is prohibited.
####

####
## BenchChain TestNet Application Input Params
####

BENCH=/benchchain-test/${BENCH:-benchchain-test}
ID=${ID:-0}
LOG=${LOG:-benchchain-test.log}

####
## Install BenchChain Testnet On Linux
####
if ! [ -f "${BENCH}" ]; then
	echo "The BenchCore application $(basename "${BENCH}") was not found. Please add the BenchChain application to the folder inside the '$BENCH' variable within 'benchchain-test.sh' . Please use the BENCH environment variable if the name of the BenchChain image is not 'benchchain-test' E.g.: -e BENCH=sidechain"
	exit 1
fi
BENCH_CHECK="$(file "$BENCH" | grep 'ELF 64-bit LSB executable, x86-64')"
if [ -z "${BENCH_CHECK}" ]; then
	echo "Server OS needs to be a flavor of Linux (Ubuntu, Debian, CentOS) or ARCH amd64"
	exit 1
fi

####
## Run BenchChain Testnet With All Available Params
####
export BCHOME="/benchchain-test/node${ID}"

if [ -d "`dirname ${BCHOME}/${LOG}`" ]; then
  "$BENCH" "$@" | tee "${BCHOME}/${LOG}"
else
  "$BENCH" "$@"
fi

chmod 777 -R /benchchain-test
