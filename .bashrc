#!/usr/bin/env bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# added by travis gem
[ -f /Users/malcolm/.travis/travis.sh ] && source /Users/malcolm/.travis/travis.sh

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/local/bin/cless ] && eval "$(SHELL=/bin/sh cless)"

# # enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#   alias ls='ls --color=auto'
#   alias dir='dir --color=auto'
#   alias vdir='vdir --color=auto'

#   alias grep='grep --color=auto'
#   alias fgrep='fgrep --color=auto'
#   alias egrep='egrep --color=auto'
# fi
