#!/usr/bin/env bash
set -euo pipefail

repository=${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}
branch=${GITHUB_REF_NAME:-main}

git config --global --add safe.directory "$PWD"
git init
git remote add origin "https://github.com/${repository}.git"
git fetch --depth=1 origin "$branch"
git checkout --force -B "$branch" FETCH_HEAD
git submodule update --init --recursive
