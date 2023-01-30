#!/usr/bin/env sh

. "${GITHUB_ACTION_PATH}/scripts/utils.sh"

init() {
  echo "::group::${1}"
}

teardown() {
  echo "::endgroup::"
}

setup_bin() {
  init "Setup Bin Folder"
  setup
  echo "${BIN_PATH}" >> "$GITHUB_PATH"
  teardown
}

setup_jq() {
  init "Setup jq"
  downloadBinary "stedolan" "jq" "jq" "jq-${1}" "jq-linux64"
  teardown
}

setup_auto() {
  init "Setup Auto"
  downloadAsset "intuit" "auto" "auto" "${1}" "auto-linux.gz"
  teardown
}