#!/bin/bash

up () {
    if [ "${1}." == "--help." -o "${1}." == "-h." ]; then
        echo 'Usage: '
        echo '    up           # equal to "cd .."'
        echo '    up <n>       # equal to "cd ..", repeated <n> times'
        echo '    up <dirname> # equal to "cd ..", repeated until current directory name is <dirname>'
        echo '                 # If no such directory found, equal to "up 1"'
    fi

    howmuch=$1
    if [ "${howmuch}." == . ]; then
        howmuch=1
    fi
    expr match "${howmuch}" '^[0-9]*$' > /dev/null
    if [ $? != 0 ]; then
        # not a number
        found=""
        path=""
        IFS='/' read -ra DIRS <<< "${PWD}"
        for dir in "${DIRS[@]}"; do
            if [ "${dir}." != . ]; then
                path="${path}/${dir}"
            fi
            if [ "${dir}" == "${howmuch}" ]; then
                if [ "${PWD}" != "${path}" ]; then
                    # there we go
                    found=$path
                fi
            fi
        done
        if [ "${found}." != . ]; then
            # we have found this path
            cd "${found}"
            return
        fi
        howmuch=1
    fi
    while [ $howmuch -gt 0 ]; do
        cd ..
        let 'howmuch -= 1'
    done
}

alias back='cd "$OLDPWD"'

alias stay='SAVEDPWD="$PWD"'
alias ret='if [ "${SAVEDPWD}." == . ]; then echo "No saved path"; else cd "$SAVEDPWD"; fi'
