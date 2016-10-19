#!/bin/bash
#
# Bash utils
# Parameters helpers

# checks that argument passed is a simple parameter
# usage:
# 	is_param -b #returs true
# 	is_param b  #returns false
function is_param {
	expr match $1 '^-.*$' > /dev/null
	return $?
}
export -f is_param

# checks that argument passed is a long parameter
# usage:
# 	is_param --param		#returs true
# 	is_param not_a_param	#returns false
function is_long_param {
	expr match $1 '^--.*$' > /dev/null
	return $?
}
export -f is_long_param

# checks that the given param exists in following parameters list
# usage:
# 	has_long_param --param $*
# 	has_long_param --param --param1 --param2 not_a_param --param #false
function has_long_param {
	look_for=$1
	shift
	while (( $# )); do
		if ! is_long_param $1; then
			# parameters for command ended
			break
		fi

		if [ $look_for. == $1. ]; then
			return 0
		fi
		shift
	done
	return 1
}
export -f has_long_param

# checks that the given short param exists in next argument
# usage:
# 	has_short_param -p $1
# 	has_short_param -p -pbs
function has_short_param {
	look_for=$1
	all_params=$2
	if [ $all_params. == . ]; then
		return 1
	fi
	expr match $all_params "^-[A-Za-z0-9]*$look_for.*" > /dev/null
	return $?
}
export -f has_short_param

# returns true if there is either short or long version of a param in arguments list
# usage:
# 	has_param -p --param $*
# 	has_param -p --param --param1 -pbs
function has_param {
	short_version=$1
	long_version=$2
	shift 2
	where_to_look=$*
	if has_long_param $long_version $where_to_look; then
		return 0
	fi
	if has_short_param $short_version $where_to_look; then
		return 0
	fi
	return 1
}
export -f has_param

# reads all arguments and writes them into stdout until they stop being a parameter
# usage:
# 	splice_params $*
# 	my_cmd `splice_params $*`
function splice_params {
	while (( $# )); do
		if is_param $1; then
			echo -n $1
			shift
		else
			break
		fi
	done
}
export -f splice_params
