#!/bin/sh

cd doc || exit
make HUGO_ARGS="--verbose --debug --printPathWarnings"

echo "USE_GIT_COMMIT=${GIT_COMMIT}" > "${WORKSPACE}"/trigger.property
