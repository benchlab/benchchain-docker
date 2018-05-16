# Makefile For The Official BenchChain Testnet Docker Image
# Copyright 2018 Bench Computer, Inc. All rights reserved.
# Use of this source code is governed by the BENCH License
# The BENCH license can be found in the LICENSE file in the root directory of this software.
# This software my utilize other software libraries that are mentioned in benOS License Agreement
# For the license agreement, go to: https://github.com/benchlab/benOS/blob/master/ATTRIBUTES.md
# Using this software to issue illegal securities is prohibited.

all:
	docker build --tag benchlab/benchchain-test benchchain-test

.PHONY: all
