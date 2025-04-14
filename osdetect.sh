#!/bin/bash
#
# Detected operating systems:
# - Linux
# - Windows
# - MacOS
#

if type -t wevtutil &> /dev/null
    then
        OS=Windows
elif type -t scutil &> /dev/null
    then
        OS=MacOS
else
    OS=Linux
fi

echo $OS

exit 0

