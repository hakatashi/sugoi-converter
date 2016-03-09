#!/bin/bash

# Exit on error
set -ev

if [ "$TRAVIS_SECURE_ENV_VARS" != "true" ] || [ "$TRAVIS_NODE_VERSION" != "node" ] || [ "$TRAVIS_BRANCH" != "master" ] || [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
	exit 0
fi

# Convert clone to the full clone
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch --unshallow

# Set identification
git config user.name "Travis CI"
git config user.email "hakatasiloving@gmail.com"

# Discard any changes in build
git checkout -- .

# Checkout and merge
git checkout gh-pages
git merge -X theirs "$TRAVIS_COMMIT" --no-edit

# Update version - build is automatically done by npm
npm version patch

# Push it all
git push "https://${GH_TOKEN}@github.com/hakatashi/sugoi-converter.git" gh-pages:gh-pages --follow-tags > /dev/null 2>&1

sumcol() {
	awk "{sum+=\$$1} END {print sum}"
}

# File size report
FILE_SIZE=`ls {index.html,index.min.js,index.min.css} -lrt | sumcol 5`
JS_SIZE=`ls index.min.js -lrt | sumcol 5`

echo "Total File Size: $FILE_SIZE"
echo "JavaScript File Size: $JS_SIZE"

curl -X POST -H "Content-Type: application/json" -k -s \
-d "{\"value1\":\"${TRAVIS_BUILD_NUMBER}\",\"value2\":\"${FILE_SIZE}\",\"value3\":\"${JS_SIZE}\"}" \
"https://maker.ifttt.com/trigger/travis-sugoi-converter/with/key/${IFTTT_TOKEN}"
