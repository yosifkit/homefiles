#!/bin/bash
set -e

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

git -C "$thisDir" fetch --all -p
git -C "$thisDir" checkout master
git -C "$thisDir" pull tianon master
git -C "$thisDir" push
