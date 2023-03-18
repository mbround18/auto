#!/usr/bin/env bash

echo "::group::Run Auto"
set -o pipefail

OUTPUT_FILE="/tmp/${GITHUB_RUN_ID:-"unknown"}-auto.out"

eval "auto ${1}" 2>&1 | tee "${OUTPUT_FILE}"

AUTO_EXIT="$?"

echo "::endgroup::"
exit $AUTO_EXIT
