#!/bin/bash

# added        Add a new feature to the changelog
# changed      Add a new change to the changelog
#	deprecated   Add a new deprecation to the changelog
#	fixed        Add a new bug fix to the changelog
#	removed      Add a new removal to the changelog
#	security     Add a new security fix to the changelog
#

echo
echo

read -p "Enter (added, changed, deprecated, fixed, removed, or security): " logType

string_to_check="$logType"

found_in_case=false

case "$string_to_check" in
    added|changed|deprecated|fixed|removed|security)
        found_in_case=true
        ;;
    *) # Default case if no match
        found_in_case=false
        ;;
esac

if [ "$found_in_case" = false ]; then
    echo "'$string_to_check' is not a cider log type!"
		exit 255
fi


read -p "Enter description: "  descr
cider log "$logType" "$descr"
