#!/bin/sh

export MAKEOBJDIRPREFIX=/tmp/obj
rm -fr ${MAKEOBJDIRPREFIX}

MAKECONF=/dev/null
SRCCONF=/dev/null

KERNCONF=${KERNCONF:-LINT}

cd ${WORKSPACE}/src/sys/${TARGET}/conf
make LINT

cd ${WORKSPACE}/src

make -s -de -j ${JFLAG} \
	-DNO_CLEAN \
	TARGET=${TARGET} \
	TARGET_ARCH=${TARGET_ARCH} \
	kernel-toolchain \
	KERNCONF=${KERNCONF} \
	__MAKE_CONF=${MAKECONF} \
	SRCCONF=${SRCCONF} \
	${EXTRA_FLAGS}

make -s -de -j ${JFLAG} \
	-DNO_CLEAN \
	TARGET=${TARGET} \
	TARGET_ARCH=${TARGET_ARCH} \
	buildkernel \
	KERNCONF=${KERNCONF} \
	__MAKE_CONF=${MAKECONF} \
	SRCCONF=${SRCCONF} \
	${EXTRA_FLAGS}
