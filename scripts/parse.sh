#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

FILE="${1}"

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



