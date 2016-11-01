#!/bin/bash
. params.sh

fmap () {
	# fmap <f>, array goes from stdin
	if [ "${1}." == "--help." ]; then
		echo 'fmap: maps a lines array into other array with given function'
		echo 'Usage:'
		echo '    fmap --help                       Print this message and exit     '
		echo '    fmap [<func>=identity]            Map the array with <func>. The  '
		echo '                                      <func> must be a shell command  '
		echo '    fmap [<func>=identity] --stdin    Flag --stdin says that lines    '
		echo '                                      will be given into <func> stdin '
		echo '                                      (enabled by default)            '
		echo '    fmap [<func>=identity] --arg      Opposite to --stdin: lines will '
		echo "                                      be given into <func> as it's    "
		echo "                                      first argument: <func> <line>   "
		echo "                                      (note that the first arg        "
		echo "                                      contains the whole line)        "
		return 0
	fi

	fn="${1}"
	use="stdin"
	if [ "${fn}." == . ]; then
		fn='cat'
	else
		way="--stdin"
		if is_long_param "${1}"; then
			way="${1}"
		else
			way="${2}"
		fi

		if [ "${way}." != "." ]; then
			case "${way}" in
			 	'--stdin' )
					# nothing
					;;
				'--arg' )
					use="arg"
			 		;;
			 	* )
					echo "Incorrect argument: '${way}'. Type fmap --help for usage description."
					return 1
			esac
		fi
	fi


	line=""
	while read line; do
		if [ $use == "stdin" ]; then
			echo "${line}" | ${fn}
		else
			echo `${fn} "${line}"`
		fi
	done
}