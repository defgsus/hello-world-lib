#!/usr/bin/env bash

HELLO_WORLD_VERSION=$(./build_versionstring.sh)
RELEASE_DATE=$(date +"%Y %B %d")

sed -e "s|__HELLO_WORLD_VERSION__|$HELLO_WORLD_VERSION|g" \
    -e "s|__RELEASE_DATE__|$RELEASE_DATE|g" manpage.md \
    | pandoc -f markdown -s -t man -o - | man -l -
