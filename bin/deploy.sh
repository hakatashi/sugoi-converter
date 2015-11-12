#!/bin/bash

# Exit on error
set -ev

if [ "$TRAVIS_SECURE_ENV_VARS" != "true" ] || [ "$TRAVIS_NODE_VERSION" != "node" ]; then
	exit 0
fi

NPM_BIN=`npm bin`

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
git merge "$TRAVIS_COMMIT" --no-edit

# Build release files
$NPM_BIN/gulp release

# Create commit
git add index.html
git add index.min.js
git add index.min.css
git commit -m "Update build"

# Push it all
git push "https://${GH_TOKEN}@github.com/hakatashi/sugoi-converter.git" gh-pages:gh-pages > /dev/null 2>&1

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
