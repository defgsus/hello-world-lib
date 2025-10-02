#!/usr/bin/env bash

set -e


export RELEASE_VERSION=$(./build-versionstring.sh)
export RELEASE_TAG=$(git describe --abbrev=0 || echo "XXX")
export RELEASE_DATE=$(date +"%Y %B %d")

# -- create dist/ folder --

rm -rf dist
mkdir dist
cd dist
cp ../hello-world .
cp ../README.md .
cp ../LICENSE .

# render manpage to dist folder
sed -e "s|__RELEASE_VERSION__|$RELEASE_VERSION|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" ../manpage.md > manpage.md

cd ..

# -- create docs/ folder --

rm -rf docs/
mkdir docs
touch docs/.nojekyll

sed -e "s|__RELEASE_VERSION__|$RELEASE_VERSION|g" \
    -e "s|__RELEASE_TAG__|$RELEASE_TAG|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" index.md \
    | pandoc -f markdown -s -t html -o docs/index.html

sed -e "s|__RELEASE_VERSION__|$RELEASE_VERSION|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" manpage.md \
    | pandoc -f markdown -s -t html -o docs/manpage.html
