#!/bin/bash

# breaking   Bump the breaking version
#  build      Bump the build version
#  major      Bump the major version
#  minor      Bump the minor version
#  patch      Bump the patch version
#  pre        Bump the pre-release version
#  release    Bump the release version

echo
echo

read -p "Enter (build, major, minor, patch, pre, or release): " bumpType

string_to_check="$bumpType"

found_in_case=false

case "$string_to_check" in
    build|major|minor|patch|pre|release)
        found_in_case=true
        ;;
    *) # Default case if no match
        found_in_case=false
        ;;
esac

if [ "$found_in_case" = false ]; then
    echo "'$string_to_check' is not a cider bump type!"
		exit 255
fi

cider bump "$bumpType"
