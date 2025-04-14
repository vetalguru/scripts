#!/bin/bash
#
# Usage:
#    bash get_host_info.sh < commands.txt
#
#    commands.txt - file with list of command to execute
#

function SepCmds ()
{
    LCMD=${ALINE%%|*}
    REST=${ALINE#*|}
    WCMD=${REST%%|*}
    REST=${REST#*|}
    TAG=${REST%%|*}
    REST=${REST#*|}

    if [[ $OSTYPE == "Windows" ]]
    then
        CMD="$WCMD"
    else
        CMD="$LCMD"
    fi
}

function DumpInfo ()
{
    printf '<systeminfo host="%s" type="%s"' "$HOSTNAME" "$OSTYPE"
    printf ' date="%s" time="%s">\n' "$(date '+%F')" "$(date '+%T')"
    readarray CMDS
    for ALINE in "${CMDS[@]}"
    do
        if [[ ${ALINE:0:1} == '#' ]]; then continue; fi

        SepCmds

        if [[ ${CMD:0:3} == N/A ]]
        then
            continue
        else
            printf "<%s>\n" $TAG
            $CMD
            printf "</%s>\n" $TAG
        fi
    done
    printf "</systeminfo>\n"
}

OSTYPE=$(./osdetect.sh)
HOSTNAME=$(hostname)
TMPFILE="${HOSTNAME}.info"

DumpInfo > $TMPFILE 2>&1

exit 0

