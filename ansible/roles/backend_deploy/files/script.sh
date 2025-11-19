#!/bin/bash
set -euo pipefail

BACK_URL="${NEXUS_REPO_URL%/}/repository/${NEXUS_REPO_BACKEND_NAME}/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar"

curl --fail -u "${NEXUS_REPO_USER}:${NEXUS_REPO_PASS}" -o sausage-store.jar "${BACK_URL}"

scp -i ~/.ssh/id_ci -o IdentitiesOnly=yes \
    -P "${DEV_PORT:-22}" \
    sausage-store.jar \
    "${DEV_USER_BACK}@${DEV_HOST}:/opt/sausage-store/bin/sausage-store-${VERSION}.jar"

ssh -i ~/.ssh/id_ci -o IdentitiesOnly=yes \
    -p "${DEV_PORT:-22}" \
    "${DEV_USER_BACK}@${DEV_HOST}" \
    "ln -sfn /opt/sausage-store/bin/sausage-store-${VERSION}.jar /opt/sausage-store/bin/sausage-store.jar"

ssh -i ~/.ssh/id_ci -o IdentitiesOnly=yes \
    -p "${DEV_PORT:-22}" \
    "${DEV_USER_BACK}@${DEV_HOST}" \
    "sudo systemctl restart sausage-backend.service && sudo systemctl is-active --quiet sausage-backend.service"

curl --request POST \
    --form token=${CI_JOB_TOKEN} \
    --form ref=${CI_COMMIT_REF_NAME} \
    --form "variables[FORCE_ROLLBACK_BACKEND]=true" \
    "https://gitlab.com/api/v4/projects/${CI_PROJECT_ID}/trigger/pipeline"

curl -I http://std-ext-023-27.praktikum-services.tech/api/orders/
