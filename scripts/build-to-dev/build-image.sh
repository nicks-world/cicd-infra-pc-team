#!/usr/bin/bash
# Build from image

set -x
REPO_NAME=$(cut -d '/' -f2 :"${BUILD_REPO}")

HAS_BC=$(oc get bc --no-headers -o custom-columns=:.metadata.name --ignore-not-found ${REPO_NAME} -n ${CICD_NAMESPACE})
if [[ -z ${HAS_BC} ]]
then
    oc new-build --name ${REPO_NAME} \
                 --binary=true \
                 --label=${BUILD_REPO} \
                 --strategy=docker \
                 --to-docker \
                 -n ${CICD_NAMESPACE}
fi

cp ${CICD_REPO_SCRIPTS_DIR}/docker/Dockerfile.java11-mvn-gradle ./Dockerfile
oc start-build ${REPO_NAME} --from-dir=. --wait --follow -n ${CICD_NAMESPACE}

set +x