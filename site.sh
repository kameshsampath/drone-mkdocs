#!/usr/bin/env bash

set -e
set -o pipefail

if [ -n "${PLUGIN_PIP_MODULES}" ];
then
	echo "Installing extra modules ${PLUGIN_PIP_MODULES}"
fi

mkdir -p /build/site

mkdocs build --clean --site-dir /build/site