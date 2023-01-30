#!/usr/bin/env bash

echo "::group::Run Auto"
set -o pipefail

OUTPUT_FILE="/tmp/auto.out"


exec "auto ${1}" 2>&1 | tee "${OUTPUT_FILE}"

AUTO_EXIT="$?"

echo "::endgroup::"
exit $AUTO_EXIT
