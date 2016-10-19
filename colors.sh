#!/bin/bash
#
# Bash utils
# Text formatting tools module

# Color constants
# Foreground:
export FC_DEFAULT='\e[39m'	# default foreground color
export FC_BLACK='\e[30m'	# black foreground color
export FC_RED='\e[31m'		# red foreground color
export FC_GREEN='\e[32m'	# green foreground color
export FC_YELLOW='\e[33m'	# yellow foreground color
export FC_BLUE='\e[34m'		# blue foreground color
export FC_MAGENTA='\e[35m'	# magenta foreground color
export FC_CYAN='\e[36m'		# cyan foreground color
export FC_LGRAY='\e[37m'	# light gray foreground color

export FC_DGRAY='\e[90m'	# dark gray foreground color
export FC_LRED='\e[91m'		# light red foreground color
export FC_LGREEN='\e[92m'	# light green foreground color
export FC_LYELLOW='\e[93m'	# light yellow foreground color
export FC_LBLUE='\e[94m'	# light blue foreground color
export FC_LMAGENTA='\e[95m'	# light magenta foreground color
export FC_LCYAN='\e[96m'	# light cyan foreground color
export FC_WHITE='\e[97m'	# white foreground color

# Background:
export FB_DEFAULT='\e[49m'	# default background color
export FB_BLACK='\e[40m'	# black background color
export FB_RED='\e[41m'		# red background color
export FB_GREEN='\e[42m'	# green background color
export FB_YELLOW='\e[43m'	# yellow background color
export FB_BLUE='\e[44m'		# blue background color
export FB_MAGENTA='\e[45m'	# magenta background color
export FB_CYAN='\e[46m'		# cyan background color
export FB_LGRAY='\e[47m'	# light gray background color

export FB_DGRAY='\e[100m'		# dark gray background color
export FB_LRED='\e[101m'		# light red background color
export FB_LGREEN='\e[102m'		# light green background color
export FB_LYELLOW='\e[103m'		# light yellow background color
export FB_LBLUE='\e[104m'		# light blue background color
export FB_LMAGENTA='\e[105m'	# light magenta background color
export FB_LCYAN='\e[106m'		# light cyan background color
export FB_WHITE='\e[107m'		# white background color

# Formatting constants
export FC='\e[0m'			# clear
export FB='\e[1m'			# bold
export F_DIM='\e[2m'		# dim
export FI='\e[3m'			# italic
export FU='\e[4m'			# underline
export F_INV='\e[7m'		# inversion

# Shortcuts:
export FR=$FC_RED
export FG=$FC_GREEN
export FCB=$FC_BLUE
export FBR=$FB_RED
export FBG=$FB_GREEN
export FBB=$FB_BLUE

# Functions
function writelf {
	echo -en $*
	echo -e $FC
}
export -f writelf

function writef {
	echo -en $*
	echo -en $FC
}
export -f writef

function writeer {
	echo -en "${FR}${FB}$*${FC}"
}
export -f writeer

function writesc {
	echo -en "${FG}${FB}$*${FC}"
}
export -f writesc

function writeem {
	echo -en "${FCB}${FB}$*${FC}"
}
export -f writeem

function set_global_format {
	echo -e $*
	clear
}
export -f set_global_format

function clear_global_format {
	echo -e $FC
	clear
}
export -f clear_global_format
