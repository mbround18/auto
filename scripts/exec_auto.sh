#!/usr/bin/env bash

echo "::group::Run Auto"
set -o pipefail

BIN_PATH="${GITHUB_ACTION_PATH}/.bin/auto"
TMP_DIRECTORY="${GITHUB_ACTION_PATH}/.tmp"
OUTPUT_FILE="${TMP_DIRECTORY}/${GITHUB_RUN_ID:-"unknown"}-auto.out"
echo "OUTPUT_FILE=${OUTPUT_FILE}"

if ! [ -d "${TMP_DIRECTORY}" ]; then
  mkdir -p "${TMP_DIRECTORY}"
fi

eval "${BIN_PATH} ${1}" |& tee "${OUTPUT_FILE}"

AUTO_EXIT="$?"

echo "::endgroup::"
exit $AUTO_EXIT
