#!/usr/bin/env bash

set -e

if [[ -z $RELEASE_VERSION ]]; then
  export RELEASE_VERSION=$(./build-versionstring.sh)
fi
if [[ -z $RELEASE_TAG ]]; then
  export RELEASE_TAG=$(git describe --abbrev=0 || echo "XXX")
fi
if [[ -z $RELEASE_DATE ]]; then
  export RELEASE_DATE=$(date +"%Y %B %d")
fi

echo "Building docs: ${RELEASE_VERSION}"

# -- create docs/ folder --

rm -rf docs/
mkdir docs
touch docs/.nojekyll

# -- render html content --

sed -e "s|__RELEASE_VERSION__|$RELEASE_VERSION|g" \
    -e "s|__RELEASE_TAG__|$RELEASE_TAG|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" index.md \
    | pandoc -f markdown -s -t html -o docs/index.html

sed -e "s|__RELEASE_VERSION__|$RELEASE_VERSION|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" manpage.md \
    | pandoc -f markdown -s -t html -o docs/manpage.html
