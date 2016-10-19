#!/bin/bash

source "/home/bob/bin/scripts/colors.sh"

writef "$FR" RED
writef "$FG" GREEN
writef "$FCB" BLUE

writef $FB BOLD $FC
writef $FU UNDERLINE $FC
writef $F_BLINK BLINK $FC

writef " ${FB_LRED}TEST${FC}"
writef " ${FB_DGRAY}TEST${FC}"
