#!/usr/bin/env bash

# directory traversing
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -la'
alias ldir="ls -l | grep '^d'"

alias cachekill='sudo killall -HUP mDNSResponder'
alias dnscache="dscacheutil -flushcache && killall -HUP mDNSResponder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias behue='hue -H 10.32.81.86'
alias buildlights='for i in {1..10}; do behue light 1 red && behue light 3 green && sleep 0.25 && behue light 1 blue && behue light 3 orange && sleep 0.25 && behue light 1 purple && behue light 3 yellow && sleep 0.25; done'
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias pjson='python -mjson.tool'
alias brspec='bundle exec rspec'
alias biv='bundle install --path .vendor'
alias bek='bundle exec kitchen'
alias bekl='bundle exec kitchen login'
alias cspec='bundle exec rspec --color --format documentation'

## Processes
alias tu='top -o cpu' #cpu
alias tm='top -o vsize' #memory

## Various
alias h='history'
alias cdd='cd -'
alias count='du -a | cut -d/ -f2 | sort | uniq -c | sort -nr'
alias grep='grep --colour'
alias psaux='ps aux | grep -v grep | grep -i'
alias routeprint='netstat -r'

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="sudo ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | xclip -selection clipboard"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Lock the screen (when going AFK)
alias afk="i3lock -c 000000"

# vhosts
alias hosts='sudo vim /etc/hosts'

# copy working directory
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

# untar
alias untar='tar xvf'

alias find_all_devices_on_network="nmap -sP -PA22,25,3389 192.168.2.1/24"
