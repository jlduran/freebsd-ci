#!/bin/sh

. freebsd-ci/scripts/jail/jail.conf

echo "clean jail ${JNAME}"

sudo jexec "${JNAME}" sh -c "find ${WORKSPACE_IN_JAIL} -d -not -user jenkins -flags +schg -exec chflags noschg {} \;" || true
sudo jexec "${JNAME}" sh -c "find ${WORKSPACE_IN_JAIL} -d -not -user jenkins -exec rm -rf {} \;" || true

sudo jail -r "${JNAME}" || true

if [ "${BUILDER_NETIF}" ] && [ "${BUILDER_JAIL_IP6}" ]; then
	sudo ifconfig "${BUILDER_NETIF}" inet6 "${BUILDER_JAIL_IP6}" -alias || true
fi
if [ "${BUILDER_NETIF}" ] && [ "${BUILDER_JAIL_IP4}" ]; then
	sudo ifconfig "${BUILDER_NETIF}" inet "${BUILDER_JAIL_IP4}" -alias || true
fi

if [ -n "${MOUNT_REPO}" ]; then
	sudo umount "${JPATH}"/usr/"${MOUNT_REPO}" || true
fi
sudo umount "${JPATH}"/"${WORKSPACE_IN_JAIL}" || true
sudo umount "${JPATH}"/dev || true

sudo zfs destroy "${ZFS_PARENT}"/"${JNAME}" || true
