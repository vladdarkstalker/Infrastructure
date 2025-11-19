#!/bin/bash

if [ "$CI_JOB_STATUS" != "success" ]; then
curl --request POST \
    --form token=${CI_JOB_TOKEN} \
    --form ref=${CI_COMMIT_REF_NAME} \
    --form "variables[FORCE_ROLLBACK_BACKEND]=true" \
    "https://gitlab.com/api/v4/projects/${CI_PROJECT_ID}/trigger/pipeline"
fi
