#!/bin/bash
set -e

thisDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

if [ -e "$thisDir/resync-master.sh" ]; then
	"$thisDir/resync-master.sh"
fi

git -C "$thisDir" checkout yosifkit
git -C "$thisDir" rebase master
git -C "$thisDir" status
#git -C "$thisDir" push -f
