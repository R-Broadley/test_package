#!/bin/sh

NOTOX="${1:-none}"

function rm_if_dir {
	if [ -d "$1" ]
		then
			echo "removing '$1' (and everything under it)"
			rm -Rf "$1"
	fi
}

function rm_if_file {
	if [ -f "$1" ]
		then
			echo "removing '$1'"
			rm -f "$1"
	fi
}

if [ $NOTOX != "--notox" ]
then
	rm_if_dir .tox
fi
rm_if_dir docs/_build
rm_if_dir docs/source/api
rm_if_dir reports
rm_if_file requirements.txt
coverage erase
python setup.py clean --build --dist --eggs --pycache
