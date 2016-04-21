#!/bin/bash

set -o errexit -o nounset

echo "This commit was made against the $TRAVIS_BRANCH branch."
echo "Deploying to Upload"
export DEPLOY_PORT=2225

# SCP to Server
echo Prepare key
chmod 0600 ssh_ida_travis_rsa
echo RSYNC to server
rsync -az -e "ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR -p $DEPLOY_PORT -i ssh_ida_travis_rsa" anreicherung data institution arbeitsxml.xml arbeitsxml.xsd $DEPLOY_USER@$DEPLOY_HOST:/var/local/ida/transformation