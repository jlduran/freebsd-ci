#!/bin/sh

env \
	JFLAG="${BUILDER_JFLAG}" \
	TARGET=amd64 \
	TARGET_ARCH=amd64 \
	EXTRA_FLAGS=LD=ld.lld \
	sh -x freebsd-ci/scripts/build/build-kernel-LINT.sh
