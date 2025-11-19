#!/bin/bash
set -euo pipefail

FRONT_URL="${NEXUS_REPO_URL%/}/repository/${NEXUS_REPO_FRONTEND_NAME}/${VERSION}/frontend-${VERSION}.tar.gz"

# отладка (можно потом убрать)
echo "=== FRONT DEBUG: try ssh with key ==="
ssh -i ~/.ssh/id_ci -o IdentitiesOnly=yes \
    -p "${DEV_PORT:-22}" \
    "${DEV_USER_FRONT}@${DEV_HOST}" \
    "echo FRONT_SSH_OK" || echo "FRONT_SSH_FAILED"

# боевой деплой
ssh -i ~/.ssh/id_ci -o IdentitiesOnly=yes \
    -p "${DEV_PORT:-22}" \
    "${DEV_USER_FRONT}@${DEV_HOST}" \
    bash -s -- "${FRONT_URL}" "${NEXUS_REPO_USER}:${NEXUS_REPO_PASS}" "${VERSION}" <<'REMOTE'
set -e
URL="$1"
CREDS="$2"
VER="$3"

mkdir -p "/var/www-data/releases/${VER}"
curl --fail -u "${CREDS}" -o "/var/www-data/releases/${VER}/frontend.tar.gz" "${URL}"
tar xzf "/var/www-data/releases/${VER}/frontend.tar.gz" -C "/var/www-data/releases/${VER}"
rm -f "/var/www-data/releases/${VER}/frontend.tar.gz"

ln -sfn "/var/www-data/releases/${VER}/dist/frontend" "/var/www-data/dist/frontend"

find /var/www-data/releases -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' \
  | sort -nr | tail -n +6 | cut -d' ' -f2- | xargs -r rm -rf
REMOTE
