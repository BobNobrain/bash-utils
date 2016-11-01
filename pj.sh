#/bin/bash

#
# pj navigation util
#

# config path
pj_list_path=~/bin/scripts/pj.list
pj_list_path_temp=~/bin/scripts/pj.list.tmp

init_pj_list () {
	if ! [ -f "${pj_list_path}" ]; then
		touch "${pj_list_path}"
		chmod +rw "${pj_list_path}"
	fi
}

create_temp () {
	cp "${pj_list_path}" "${pj_list_path_temp}"
}
remove_temp () {
	rm "${pj_list_path_temp}"
}

pj () {
	command="${1}"
	if [ "${command}." == . -o "${command}." == "--help." ]; then
		echo "Usage:"
		echo   "    pj                      " "Show this message and exit"
		echo   "    pj --help               " ""
		echo   "    pj list                 " "Print list of all registered navigation points"
		echo   "    pj add <name> <path>    " "Add a new navigation point with acronym <name>"
		echo   "                            " "and referencing to location <path>"
		echo   "    pj rm <name>            " "Removes reference with acronym <name>"
		echo   "    pj edit [<cmd>]         " "Edit configuration file with specified <cmd>"
		echo   "                            " "(default is gedit)"
		echo   "    pj <name> [<cmd>]       " "Navigate to location referenced with <name> or"
		echo   "                            " "open it with <cmd> if specified."
		return 1
	fi

	init_pj_list

	case "${command}" in
		"list" )
			counter=0
			while read record; do
				if ! [ "${record}." == "." ]; then
					echo "${record}"
					let "counter+=1"
				fi
			done < "${pj_list_path}"
			echo "Total ${counter} names"
			return 0
			;;

		"add" )
			name="${2}"
			path="${3}"
			added_new=""
			echo "Added ${path} as ${name}"
			return 0
			;;

		"edit" )
			cmd="${2}"
			if [ "${cmd}." == "." ]; then
				cmd="gedit"
			fi
			echo "Editing paths with ${cmd}..."
			return 0
			;;

		"rm" )
			name="${2}"
			if [ "${name}." == "." ]; then
				echo "No name specified for rm command. Try executing pj --help."
				return 2
			fi
			echo "Removing ${name}..."
			return 0
			;;

		* )
			name="${1}"
			cmd="${2}"
			if [ "${cmd}." == "." ]; then
				cmd="cd"
			fi
			cd ..
			echo "Trying to open ${name} with ${cmd}"
			return 0
			;;
	esac
}
