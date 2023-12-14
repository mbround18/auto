#!/usr/bin/env sh

setup() {
  echo "::group::Setup"
  export BIN_PATH="${GITHUB_ACTION_PATH}/.bin"
  mkdir -p "${BIN_PATH}"
  echo "${BIN_PATH}" >> $GITHUB_PATH


  mkdir -p "${GITHUB_ACTION_PATH}/.tmp"
  echo "::endgroup::"
}

normalizePath() {
  echo "${1}"
}

downloadBinary() {
  OWNER="$1"
  REPOSITORY="$2"
  NAME="$3"
  VERSION="$4"
  ASSET="$5"
  echo "::group::Download ${NAME}"
  echo "Setting ${NAME} path..."
  BIN_PATH="${GITHUB_ACTION_PATH}/.bin/${NAME}"
  echo "BIN_PATH=${BIN_PATH}"
  echo "Downloading ${NAME}..."
  wget -O "${BIN_PATH}" "https://github.com/${OWNER}/${REPOSITORY}/releases/download/${VERSION}/${ASSET}"
  echo "Making ${NAME} executable..."
  chmod +x "${BIN_PATH}"
  echo "${NAME} setup complete..."
  echo "::endgroup::"
}

getLatestVersion() {
  OWNER="$1"
  REPOSITORY="$2"

  if ! [ -x "$(command -v jq)" ]; then
    echo "Error: Failed to find executable 'jq'."
  fi

  LATEST=$(curl "https://api.github.com/repos/${OWNER}/${REPOSITORY}/releases/latest" -s | jq .tag_name -r | xargs)
  if [ "${LATEST}" = "null" ]; then
    echo "latest"
  else 
    echo "${LATEST}"
  fi
}

downloadAsset() {
  OWNER="$1"
  REPOSITORY="$2"
  NAME="$3"
  VERSION="$4"
  ASSET="$5"
  echo "::group::Download ${NAME}"

  echo "Setting ${NAME} path..."
  BIN_PATH="${GITHUB_ACTION_PATH}/.bin"
  BINARY_PATH="${BIN_PATH}/${NAME}"
  DOWNLOAD_URL=""
  echo "Downloading ${NAME}..."
  if [ "${VERSION}" = "latest" ]; then
    echo "Fetching latest ${NAME} release..."
    LATEST_TAG="$(getLatestVersion "${OWNER}" "${REPOSITORY}")"
    VERSION=${LATEST_TAG}
    DOWNLOAD_URL="https://github.com/${OWNER}/${REPOSITORY}/releases/download/${LATEST_TAG}"
  else
    DOWNLOAD_URL="https://github.com/${OWNER}/${REPOSITORY}/releases/download/${VERSION}"
  fi

  VERSION_NO_PREFIX="$(echo "${VERSION}" | tr -d "v")"
  ASSET_WITH_VERSION="$(echo "${ASSET}" | sed "s/{VERSION}/${VERSION}/" | sed "s/{VERSION_NO_PREFIX}/${VERSION_NO_PREFIX}/")"
  DOWNLOAD_URL="${DOWNLOAD_URL}/${ASSET_WITH_VERSION}"

  case "${ASSET_WITH_VERSION}" in
    *.tar.gz)
      wget -c "${DOWNLOAD_URL}" -O - | tar -xz -C "${BIN_PATH}"
    ;;
    *.gz)
      curl -vkL -o - "${DOWNLOAD_URL}" | gunzip > "${BINARY_PATH}"
    ;;
  esac

  echo "Making ${NAME} executable..."
  chmod +x "${BINARY_PATH}"
  echo "${NAME} setup complete..."
  echo "::endgroup::"
}
