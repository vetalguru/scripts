#!/bin/bash
#
# Using:
#    sha1search.sh <hash> <directory>
#    where:
#    	hash - SHA-1 hash of file to search
#    	directory - directory to search

HASH=$1
DIR=${2:-.}

function mkabspath ()
{
    if [[ $1 == */ ]]
    then
        ABS=$1
    else
        ABS="$PWD/$1"
    fi
}

find $DIR -type f |
while read fn
do
    THISONE=$(sha1sum "$fn")
    THISONE=${THISONE%% *}
    if [[ $THISONE == $HASH ]]
    then
        mkabspath "$fn"
	echo $ABS
    fi
done

