#!/bin/bash
set -e

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

git -C "$thisDir" pull --rebase 'https://github.com/tianon/home.git' master
git -C "$thisDir" status
echo git -C "$thisDir" push -f
