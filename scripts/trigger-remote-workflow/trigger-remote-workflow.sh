#!/usr/bin/bash
# script to trigger Github Actions workflow in held in this repository
#
# GITHUB_REPOSITORY and GITHUB_REF will be predefined by the GitHub Actions platform
#
# repos wishing to execute workflows defined in the cicd-infra repo will need a 
# cicd-infra PAT (CICD_INFRA_SVC_ACCT_PAT) added (automagically handled during onboarding)

set -x

PAYLOAD='{"ref":"main",
          "inputs": {
            "repo": "'${GITHUB_REPOSITORY}'",
            "ref": "'${GITHUB_REF}'"
          }
        }'

ACCEPT_HEADER='Accept: application/vnd.github.v3+json'
AUTHORIZATION_HEADER="Authorization: token ${CICD_INFRA_SVC_ACCT_PAT}"

REMOTE_WORKFLOW_CICD_INFRA_URL=https://api.github.com/repos/${TEAM_INFRA_REPOSITORY}/actions/workflows/${WORKFLOW_NAME}.yml/dispatches

curl -X POST -H "${ACCEPT_HEADER}" -H "${AUTHORIZATION_HEADER}" "${REMOTE_WORKFLOW_CICD_INFRA_URL}" -d "${PAYLOAD}"
set +x
