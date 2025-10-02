#!/usr/bin/env bash

set -e


export HELLO_WORLD_VERSION=$(./build-versionstring.sh)
export RELEASE_DATE=$(date +"%Y %B %d")

# -- create dist folder --

rm -rf dist
mkdir dist
cd dist
cp ../hello-world .
cp ../README.md .
cp ../LICENSE .

# render manpage to dist folder
sed -e "s|__HELLO_WORLD_VERSION__|$HELLO_WORLD_VERSION|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" ../manpage.md > manpage.md

cd ..

# -- render htmls to docs/ --

rm -rf docs/
mkdir docs

sed -e "s|__HELLO_WORLD_VERSION__|$HELLO_WORLD_VERSION|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" index.md \
    | pandoc -f markdown -s -t html -o docs/index.html

sed -e "s|__HELLO_WORLD_VERSION__|$HELLO_WORLD_VERSION|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" manpage.md \
    | pandoc -f markdown -s -t html -o docs/manpage.html
