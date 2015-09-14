#!/usr/bin/env bash

# virtual prompts
VIRTUAL_PROMPT_ENABLED=1
# virtualenv prompts
VIRTUALENV_THEME_PROMPT_PREFIX=''
VIRTUALENV_THEME_PROMPT_SUFFIX=''

VIRTUAL_THEME_PROMPT_PREFIX=' using '
VIRTUAL_THEME_PROMPT_SUFFIX=''

# Displays virtual info prompt (virtualenv/rvm)
function virtual_prompt_info() {
    local virtual_env_info=$(virtualenv_prompt)
    local virtual_prompt=""

    local prefix=${VIRTUAL_THEME_PROMPT_PREFIX}
    local suffix=${VIRTUAL_THEME_PROMPT_SUFFIX}

    # If no virtual info, just return
    [[ -z "$virtual_env_info" && -z "$rvm_info" ]] && return

    # If virtual_env info present, append to prompt
    [[ -n "$virtual_env_info" ]] && virtual_prompt="virtualenv: ${VE_COLOR}$virtual_env_info${DEFAULT_COLOR}"

    echo -e "$prefix$virtual_prompt$suffix"
}

SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" |"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

function prompt_command() {
    #PS1="${bold_cyan}$(scm_char)${green}$(scm_prompt_info)${purple}$(ruby_version_prompt) ${yellow}\h ${reset_color}in ${green}\w ${reset_color}\n${green}→${reset_color} "
    if [[ $VIRTUAL_PROMPT_ENABLED == 1 ]]; then
      PS1="\n${yellow}$(ruby_version_prompt) ${blue}$(virtual_prompt_info) ${purple}\h ${reset_color}in ${green}\w\n${bold_cyan}$(scm_char)${green}$(scm_prompt_info) ${green}→${reset_color} "
    else
      PS1="\n${yellow}$(ruby_version_prompt) ${purple}\h ${reset_color}in ${green}\w\n${bold_cyan}$(scm_char)${green}$(scm_prompt_info) ${green}→${reset_color} "
    fi
}

PROMPT_COMMAND=prompt_command;
