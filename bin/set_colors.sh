#!/usr/bin/env bash

# Put .colors.csv in your home directory
# Add the following functions to your .bash_profile
#
# Change colors and fonts of the OSX terminal from the command line:
# 
# $ set_foreground_color lime green
# $ set_font "Oxygen Mono" 12


#
# Colors for Apple Terminal
#
function list_colors {
    cat ${HOME}/.colors.csv
}

function grep_apple_color {
    grep "$*" ${HOME}/.colors.csv
}

function get_apple_color {
    egrep "(^|,)$*(,|\t)" ${HOME}/.colors.csv | cut -f 6
}

function set_foreground_color {
    color=$(get_apple_color $*)
    if [ "$color" != "" ] ; then
        osascript -e "tell application \"Terminal\" to set normal text color of window 1 to ${color}"
        echo "Normal test color set to: $*: $color"
    fi
}    

function set_background_color {
    color=$(get_apple_color $*)
    if [ "$color" != "" ] ; then
        osascript -e "tell application \"Terminal\" to set background color of window 1 to ${color}"
        echo "Background color set to: $*: $color"
    fi
}    

function set_theme {
    set_foreground_color $1
    set_background_color $2
}    

function set_font {
    osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"$1\""
    osascript -e "tell application \"Terminal\" to set the font size of window 1 to $2"
}
