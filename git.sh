gitkeep () {
    while [[ "$1." != "." ]]; do
        if [[ -d "${1}" ]]; then
            touch "${1}/.gitkeep"
        else
            echo "'${1}' is not a directory!"
        fi
        shift
    done
}
