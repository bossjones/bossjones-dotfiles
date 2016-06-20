#!/usr/bin/env bash

export EDITOR="atom -nw"

# history modifications etc
source ~/.exports

# secrets
source ~/.bossjones_extras

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='devops'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@github.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# iterm3 shell integration support, needs to happen before we start up bashit
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Load Bash It
source $BASH_IT/bash_it.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# load the last 5000 lines into memory
HISTSIZE=5000
# save 10000 lines to disk
HISTFILESIZE=10000
# Append to the Bash history file, rather than overwriting it
shopt -s histappend
# have bash immediately add commands to our history instead of waiting for the end of each session
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

### if [ -f $(brew --prefix)/etc/bash_completion ]; then
###   . $(brew --prefix)/etc/bash_completion
### fi

if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# direnv setup
eval "$(direnv hook bash)"

# tmuxifier setup
# setup: git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
[[ -e "$HOME/.tmuxifier/bin" ]] && export PATH="$HOME/.tmuxifier/bin:$PATH" && eval "$(tmuxifier init -)"
