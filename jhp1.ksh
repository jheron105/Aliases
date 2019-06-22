!/bin/bash

########################################################
# Set prompt
########################################################

N1=`who am i | cut -d' ' -f1`

DUMMY=`id | cut -d'(' -f2 | cut -d')' -f1`
if [ "$DUMMY" == "root" ] ; then PROMPT_CHAR="#"
else PROMPT_CHAR="$"
fi

PS1="
`uname -n` \d \t (\$N1) : \$PWD
${PROMPT_CHAR} "

export PS1

stty erase '^?'

########################################################
# Functions
########################################################

mg()
{
    if [[ $# == 0 ]]; then
        echo "mg: function for searching files"
        echo "    syntax: mg [-ni]"
        echo
        echo "  -ni        : Ignore case in filenames"
        echo
        return
    fi

    mg_case=-name
    mg_filepattern=*

    while [[ $# -gt 0 ]]; do
        if [[ "$1" == "-ni" ]]; then
            mg_case="-iname"
        elif [[ "$1:0:3}" == "-n:" ]]; then
            mg_filepattern="$1"
        fi

        shift
    done

    if [[ "$mg_pattern" == "*" ]]; then
        mg_fullpattern=
    else
        mg_fullpattern="$mg_case $mg_filepattern"
    fi

    echo find . -type f "$mg_fullpattern"
    find . -type f "$mg_fullpattern"
}
