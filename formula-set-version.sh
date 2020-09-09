#!/usr/bin/env bash

MN_CLI_GEM_VERSION=${1:-1.2.11}

MN_CLI_GEM_URL="https://github.com/metanorma/metanorma-cli/archive/v${MN_CLI_GEM_VERSION}.tar.gz"
MN_CLI_GEM_SHA256=$(curl -sL ${MN_CLI_GEM_URL} | shasum -a 256 | cut -d ' ' -f1)
REPLACE_MARKER_BEGIN="# > formula-set-version.sh #"
REPLACE_MARKER_END="# < formula-set-version.sh #"

case "$OSTYPE" in
	linux-gnu) SED=sed ;;
	darwin*) SED=gsed ;;
esac

${SED} -i "/${REPLACE_MARKER_BEGIN}/,/${REPLACE_MARKER_END}/c\  ${REPLACE_MARKER_BEGIN}\n  url \"${MN_CLI_GEM_URL}\"\n  sha256 \"${MN_CLI_GEM_SHA256}\"\n  ${REPLACE_MARKER_END}" Formula/metanorma-dev.rb

# TODO automate Formula/metanorma.rb version update too