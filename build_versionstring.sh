#!/usr/bin/env bash

set -e

GIT_TAG=$(git describe --abbrev=0 2>/dev/null || echo '')
GIT_TAG=$(echo $GIT_TAG | sed -e 's/-/~/' -e 's/^v//')
VERSION=$(git rev-parse --short HEAD)
if [[ -n "$GIT_TAG" ]]; then
    VERSION="$GIT_TAG-git$VERSION"
else
    VERSION="git$VERSION"
fi

echo $VERSION
