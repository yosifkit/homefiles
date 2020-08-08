#!/bin/bash
set -e

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

# git getting confused when git-config files disappear
rm -f "$thisDir/git-config.d/personal" # remove symlink

git \
	-C "$thisDir" \
	-c user.name=foo \
	-c user.email=bar@baz \
	pull \
	--rebase 'https://github.com/tianon/home.git' master

ln -s yosifkit "$thisDir/git-config.d/personal"

git -C "$thisDir" status
echo git -C "$thisDir" push -f
