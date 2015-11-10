#!/bin/bash

# Exit on error
set -ev

if [ "$TRAVIS_SECURE_ENV_VARS" != "true" ] || [ "$TRAVIS_NODE_VERSION" != "node" ]; then
	exit 0
fi

NPM_BIN=`npm bin`

# Convert clone to the full clone
git fetch --unshallow

# Set identification
git config user.name "Travis CI"
git config user.email "hakatasiloving@gmail.com"

# Discard any changes in build
git checkout -- .

# Checkout and merge
git checkout gh-pages
git merge master

# Build release files
$NPM_BIN/gulp release

# Create commit
git add index.html
git add index.min.js
git add index.min.css
git commit -m "Update build"

# Push it all
git push "https://${GH_TOKEN}@github.com/hakatashi/sugoi-converter.git" gh-pages:gh-pages > /dev/null 2>&1
