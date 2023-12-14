#!/usr/bin/env bash

echo "::group::Parse Auto"
set -o pipefail
echo "Parsing auto output..."


echo "cd $(dirname "$0")"
cd "$(dirname "$0")" || exit 1
TEMP_DIRECTORY="${GITHUB_ACTION_PATH}/.tmp"
TEMP_DIRECTORY="$(realpath "${TEMP_DIRECTORY}")"
DEFAULT_FILE="${TEMP_DIRECTORY}/${GITHUB_RUN_ID:-"unknown"}-auto.out"
FILE="${1:-"${DEFAULT_FILE}"}"
FILE="$(realpath "${FILE}")"
echo "FILE=${FILE}"

if [ -z "${FILE}" ]; then
  echo "Error: $FILE is not found!"
  exit 1
fi

CONTENT="$(cat "${FILE}")"

CANARY_FILTER="Published canary version:"
HAS_CANARY_VERSION="$(echo "${CONTENT}" | grep -c "${CANARY_FILTER}")"

TAG_CREATED_FILTER="Created GitHub release"
TAG_FILTER="Creating release on GitHub for tag:"
HAS_TAG_VERSION="$(echo "${CONTENT}" | grep -c "${TAG_CREATED_FILTER}")"

if [ "${HAS_CANARY_VERSION}" -eq "1" ]; then
  echo "${CONTENT}" | grep "${CANARY_FILTER}" | cut -d ":" -f  2 | xargs
elif [ "${HAS_TAG_VERSION}" -eq "1" ]; then
  echo "${CONTENT}" | grep "${TAG_FILTER}" | cut -d ":" -f  2 | xargs
else
  echo ""
fi



