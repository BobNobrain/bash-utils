#!/bin/bash

config_path=~/.config/ssha
config_file="${config_path}/aliases"

init_config() {
    mkdir -p "$config_path"
    touch "$config_file"
}

add_entry() {
    init_config
    echo "ssha_${1}=\"${2}\"" >> "$config_file"
}

edit_config() {
    init_config
    ${1:-nano} "$config_file"
}

run_entry() {
    init_config

    alias_name=$1
    url=$(source "$config_file"; var_name=ssha_$alias_name; echo ${!var_name})
    echo "Connecting ${url}..."
    ssh $url
}

command="$1"
shift
if [ "${command}." == "." -o "${command}." == "--help." -o "${command}." == "-h." ]; then
    echo "Usage:"
    echo "    ssha <name>               connect to aliased host"
    echo "    ssha + <name> <value>     add an alias"
    echo "    ssha -a <name> <value>"
    echo "    ssha --add <name> <value>"
    echo "    ssha -e [<editor>]        edit config file"
    echo "    ssha --edit [<editor>]"
    echo "    ssha -h, ssha --help      show this message & exit"

    if [ "${command}." == "." ]; then
        exit 1
    fi
    exit 0
fi

if [ "${command}" == "+" -o "${command}" == "-a" -o "${command}" == "--add" ]; then
    name="$1"
    shift
    value="$*"
    if [ "${name}." == "." -o "${value}." == "." ]; then
        echo "Too few arguments for ssha --add"
        exit 2
    fi

    add_entry "$name" "$value"
    exit 0
fi

if [ "${command}" == "-e" -o "${command}" == "--edit" ]; then
    edit_config "$1"
    exit 0
fi

run_entry "$command"
exit 0
