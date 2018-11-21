#!/bin/bash

# This script :
# - retrieves the commit id from the last image built
# - tag this image with the commit id

set -e # fail fast
set -o pipefail
IFS=$'\n\t'

TAG=$1

echo $OPENSHIFT_USER
echo $OPENSHIFT_SERVER
echo $BUILD_NAMESPACE
echo $BUILD
echo $TAG

if [ -z "$OPENSHIFT_USER" ]; then
    (>&2 echo "ERROR could not login OPENSHIFT_USER not set")
    exit 1
fi
if [ -z "$OPENSHIFT_PASSWORD" ]; then
    (>&2 echo "echo ERROR could not login OPENSHIFT_PASSWORD not set")
    exit 2
fi
if [ -z "$OPENSHIFT_SERVER" ]; then
    (>&2 echo "echo ERROR could not login OPENSHIFT_SERVER not set")
    exit 3
fi
if [ -z "$BUILD_NAMESPACE" ]; then
    (>&2 echo "ERROR could not login BUILD_NAMESPACE not set")
    exit 4
fi
if [ -z "$BUILD" ]; then
    (>&2 echo "echo ERROR could not login BUILD not set")
    exit 2
fi

if [ ! -z "$CIRCLE_TAG" ]; then
    TAG=$CIRCLE_TAG
fi

if [ -z "$TAG" ]; then
    (>&2 echo "echo ERROR could not login TAG not set")
    exit 5
fi

oc login ${OPENSHIFT_SERVER} -u ${OPENSHIFT_USER} -p ${OPENSHIFT_PASSWORD} > /dev/null

if [[ "$?" != "0" ]]; then
    (>&2 echo "ERROR Could not oc login. Exiting")
    exit 6
fi

set -x # debug

# apply the tag to the built image
# if you get forbidden try:
#   oc create role buildpatch --verb=patch --resource=buildconfigs.build.openshift.io  -n ${BUILD_NAMESPACE}
#   oc adm policy add-role-to-user buildpatch ${OPENSHIFT_USER} --role-namespace={BUILD_NAMESPACE} -n {BUILD_NAMESPACE}
oc patch -n ${BUILD_NAMESPACE} bc/${BUILD} -p '[{"op": "replace", "path": "/spec/source/git/ref", "value": "'$TAG'"}]' --type=json

# start the patched build
# if you get forbidden try:
#   oc create role buildinstantiate --verb=create --resource=buildconfigs.build.openshift.io/instantiate  -n ${BUILD_NAMESPACE}
#   oc adm policy add-role-to-user buildinstantiate ${OPENSHIFT_USER} --role-namespace={BUILD_NAMESPACE} -n {BUILD_NAMESPACE}
oc start-build ${BUILD} -n ${BUILD_NAMESPACE}