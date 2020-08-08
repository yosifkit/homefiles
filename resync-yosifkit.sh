#!/bin/bash
set -e

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

if [ "$1" = 'tianon' ]; then
	git \
		-C "$thisDir" \
		pull \
		'https://github.com/tianon/home.git' master

	git -C "$thisDir" status
	echo '********be sure to push updates*************'
	echo git -C "$thisDir" push
fi

ln -sf yosifkit "$thisDir/git-config.d/personal"
git pull

