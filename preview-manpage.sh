#!/usr/bin/env bash

RELEASE_VERSION=$(.build-versionstring.sh)
RELEASE_DATE=$(date +"%Y %B %d")

sed -e "s|__RELEASE_VERSION__|$RELEASE_VERSION|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" manpage.md \
    | pandoc -f markdown -s -t man -o - | man -l -
