#!/usr/bin/env bash

MN_CLI_GEM_VERSION=${1:-1.2.11}

case "$OSTYPE" in
	linux-gnu) SED=sed ;;
	darwin*) SED=gsed ;;
esac

MN_CLI_GEM_URL="https://github.com/metanorma/metanorma-cli/archive/v${MN_CLI_GEM_VERSION}.tar.gz"
MN_CLI_GEM_SHA256=$(curl -sL ${MN_CLI_GEM_URL} | shasum -a 256 | cut -d ' ' -f1)
REPLACE_MARKER_BEGIN="# > formula-set-version.sh metanorma-cli #"
REPLACE_MARKER_END="# < formula-set-version.sh metanorma-cli #"
${SED} -i "/${REPLACE_MARKER_BEGIN}/,/${REPLACE_MARKER_END}/c\  ${REPLACE_MARKER_BEGIN}\n  url \"${MN_CLI_GEM_URL}\"\n  sha256 \"${MN_CLI_GEM_SHA256}\"\n  ${REPLACE_MARKER_END}" Formula/metanorma-dev.rb

PACKED_MN_URL="https://github.com/metanorma/packed-mn/archive/v${MN_CLI_GEM_VERSION}.tar.gz"
PACKED_MN_SHA256=$(curl -sL ${PACKED_MN_URL} | shasum -a 256 | cut -d ' ' -f1)
REPLACE_MARKER_BEGIN="# > formula-set-version.sh packed-mn #"
REPLACE_MARKER_END="# < formula-set-version.sh packed-mn #"
${SED} -i "/${REPLACE_MARKER_BEGIN}/,/${REPLACE_MARKER_END}/c\  ${REPLACE_MARKER_BEGIN}\n  url \"${PACKED_MN_URL}\"\n  sha256 \"${PACKED_MN_SHA256}\"\n  ${REPLACE_MARKER_END}" Formula/metanorma.rb

PACKED_MN_DARWIN_URL="https://github.com/metanorma/packed-mn/releases/download/v${MN_CLI_GEM_VERSION}/metanorma-darwin-x64.tgz"
PACKED_MN_DARWIN_SHA256=$(curl -sL ${PACKED_MN_DARWIN_URL} | shasum -a 256 | cut -d ' ' -f1)
REPLACE_MARKER_BEGIN="# > formula-set-version.sh packed-mn-darwin #"
REPLACE_MARKER_END="# < formula-set-version.sh packed-mn-darwin #"
${SED} -i "/${REPLACE_MARKER_BEGIN}/,/${REPLACE_MARKER_END}/c\      ${REPLACE_MARKER_BEGIN}\n      url \"${PACKED_MN_DARWIN_URL}\"\n      sha256 \"${PACKED_MN_DARWIN_SHA256}\"\n      ${REPLACE_MARKER_END}" Formula/metanorma.rb

PACKED_MN_LINUX_URL="https://github.com/metanorma/packed-mn/releases/download/v${MN_CLI_GEM_VERSION}/metanorma-linux-x64.tgz"
PACKED_MN_LINUX_SHA256=$(curl -sL ${PACKED_MN_LINUX_URL} | shasum -a 256 | cut -d ' ' -f1)
REPLACE_MARKER_BEGIN="# > formula-set-version.sh packed-mn-linux #"
REPLACE_MARKER_END="# < formula-set-version.sh packed-mn-linux #"
${SED} -i "/${REPLACE_MARKER_BEGIN}/,/${REPLACE_MARKER_END}/c\      ${REPLACE_MARKER_BEGIN}\n      url \"${PACKED_MN_LINUX_URL}\"\n      sha256 \"${PACKED_MN_LINUX_SHA256}\"\n      ${REPLACE_MARKER_END}" Formula/metanorma.rb
