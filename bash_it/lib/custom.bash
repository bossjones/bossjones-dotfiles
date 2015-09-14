#!/usr/bin/env bash

source ~/.bash_it/lib/extra.bash

function whosonthelan(){
  x=0
  while [ $x < 255 ]; do
      ping -c 1 192.168.1.$x &
      x=$(expr $x + 1)
  done
  # Wait a few seconds for the pings above to finish
  arp -a
}

# use this to update all github repos for chef cookbooks, rake task doesn't always do this
function chef_repos() {

  _CHEF_COMMAND=$1

  case "$_CHEF_COMMAND" in
  pull)
    _GIT_COMMAND="git pull --rebase"
  ;;
  fetch)
    _GIT_COMMAND="git fetch"
  ;;
  status)
    _GIT_COMMAND="git status"
  ;;
  checkout-master)
    _GIT_COMMAND="git checkout master"
  ;;
  stash)
    _GIT_COMMAND="git stash"
  ;;
  checkout-feature)
    _GIT_COMMAND="git checkout feature-remove-yum"
  esac

  cd ~/dev/behanceops/chef/cookbooks/;
  for i in $(find . -type d -maxdepth 1 -print); do cd $i && echo -e "\n$(pwd):\n" && $_GIT_COMMAND; cd - >> /dev/null 2>&1; done

}

function gpg_decrypt() {

  _FILE=$1

  bash /Users/malcolm/dev/behanceops/misc/secure/gpg_decrypt.sh $_FILE

}

function gpg_encrypt() {

  _FILE=$1

  bash /Users/malcolm/dev/behanceops/misc/secure/gpg_encrypt.sh $_FILE

}

function anaconda_encrypt() {

  _FILE=$1

  bash /Users/malcolm/dev/anaconda/security/gpg_encrypt.sh $_FILE

}


function anaconda_decrypt() {

  _FILE=$1

  bash /Users/malcolm/dev/anaconda/security/gpg_decrypt.sh $_FILE

}

function chef_upload_all_cookbooks() {

  cd ~/dev/behanceops/chef/cookbooks/;
  for i in $(find . -type d -maxdepth 1 -print); do cd $i && echo -e "\n$(pwd):\n" && for a in $(git tag -l); do git checkout $a && knife cookbook upload $(pwd | cut -d\/ -f8); done && cd - >> /dev/null 2>&1; done

}

function pssh_landscapes() {

  _PSSH_CMD=$1

  pssh -x "-tt" -i -h ~/.pssh/landscapes "-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" -l bossjones -P "${_PSSH_CMD}"

}

function awsb() {

  _AWS_CMD=$1

  case "$_AWS_CMD" in
  help)
   echo -e "\nCommand: awsb [status|switch|test]"
  ;;
  status)
    if [[ -e ~/.aws/config ]]; then
      _CURRENT_AWS_SERVER=$(ls -lda ~/.aws/config | awk '{ print $11}'| cut -d\- -f2)
    fi

    ls ~/.aws | grep "config-.*" | cut -d\- -f2 | sed "s,$_CURRENT_AWS_SERVER,$_CURRENT_AWS_SERVER \[ X \],g" | sed "s,^,    \* ,g"
  ;;
  switch)
    _SWITCH_TO=$2
    if [[ -L ~/.aws/config ]]; then
        \rm  ~/.aws/config
    fi

    _AWS_ENV_EXISTS=$(ls ~/.aws | grep "config-.*" | cut -d\- -f2|wc -l)
    if [[ "${_AWS_ENV_EXISTS}" = "0" ]]; then
      echo "Sorry, that AWS environment does not exist. Please try again."
      exit 1
    fi

    ln -s ~/.aws/config-$_SWITCH_TO ~/.aws/config

    echo "You are now switched to: $_SWITCH_TO. Run 'test' to verify connection"
  ;;
  test)
    if [[ -e ~/.aws/config ]]; then
      _CURRENT_AWS_SERVER=$(ls -lda ~/.aws/config | awk '{ print $11}'| cut -d\- -f2)
    fi
   _AWS_TEST=$(aws ec2 describe-instances --filters "Name=instance-type,Values=m1.small" | grep "InstanceId" | awk '{print $2}' | sed "s,\",,g" | sed "s/,//g")
    [ $? -eq 0 ] && echo -e "\n***Instance Ids****\n" && echo -e "$_AWS_TEST" | tr ' ' '\n' && echo -e "\n\n Test to AWS Environment: \"$_CURRENT_AWS_SERVER\" is successful."
  esac

}

function knife_block() {
  echo -e "$(grep chef_server_url ~/dev/behanceops/chef/.chef/knife.rb | awk '{print $2}'| sed 's,https://,,g')"
}

function ip_address() {
  echo -e "$(ifconfig en0 | grep 'inet ' | cut -d' ' -f2)"
}

function whosonthelan_adobe(){
  x=0
  while [ $x < 255 ]; do
      ping -c 1 10.32.86.$x &
      x=$(expr $x + 1)
  done
  # Wait a few seconds for the pings above to finish
  arp -a
}

# Simple calculator
calc() {
  local result=""
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
  #           └─ default (when `--mathlib` is used) is 20

  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'      `# add "0" for cases like ".5"` \
      -e 's/^-\./-0./'    `# add "0" for cases like "-.5"`\
      -e 's/0*$//;s/\.$//';  # remove trailing zeros
  else
    printf "$result"
  fi
  printf "\n"
}

# Create a new directory and enter it
mkd() {
  mkdir -p "$@" && cd "$@"
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
targz() {
  local tmpFile="${@%/}.tar"
  tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

  size=$(
  stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
  stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
  )

  local cmd=""
  if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    cmd="zopfli"
  else
    if hash pigz 2> /dev/null; then
      cmd="pigz"
    else
      cmd="gzip"
    fi
  fi

  echo "Compressing .tar using \`${cmd}\`…"
  "${cmd}" -v "${tmpFile}" || return 1
  [ -f "${tmpFile}" ] && rm "${tmpFile}"
  echo "${tmpFile}.gz created successfully."
}

# Determine size of a file or total size of a directory
fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
  diff() {
    git diff --no-index --color-words "$@"
  }
fi

# Create a data URL from a file
dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
gitio() {
  if [ -z "${1}" -o -z "${2}" ]; then
    echo "Usage: \`gitio slug url\`"
    return 1
  fi
  curl -i http://git.io/ -F "url=${2}" -F "code=${1}"
}

# Start an HTTP server from a directory, optionally specifying the port
server() {
  local port="${1:-8000}"
  sleep 1 && open "http://localhost:${port}/" &
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Compare original and gzipped file size
gz() {
  local origsize=$(wc -c < "$1")
  local gzipsize=$(gzip -c "$1" | wc -c)
  local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
  printf "orig: %d bytes\n" "$origsize"
  printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
json() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript
  else # pipe
    python -mjson.tool | pygmentize -l javascript
  fi
}

# Run `dig` and display the most useful info
digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

# Query Wikipedia via console over DNS
mwiki() {
  dig +short txt "$*".wp.dg.cx
}

# UTF-8-encode a string of Unicode symbols
escape() {
  printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi
}

# Decode \x{ABCD}-style Unicode escape sequences
unidecode() {
  perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi
}

# Get a character’s Unicode code point
codepoint() {
  perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo ""; # newline
  fi
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
getcertnames() {
  if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "Testing ${domain}…"
  echo ""; # newline

  local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" 2>&1)

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_header, no_serial, no_version, \
      no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")
    echo "Common Name:"
    echo ""; # newline
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
    echo ""; # newline
    echo "Subject Alternative Name(s):"
    echo ""; # newline
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
  else
    echo "ERROR: Certificate not found."
    return 1
  fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
v() {
  if [ $# -eq 0 ]; then
    vim .
  else
    vim "$@"
  fi
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
o() {
  if [ $# -eq 0 ]; then
    xdg-open .  > /dev/null 2>&1
  else
    xdg-open "$@" > /dev/null 2>&1
  fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
  tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# Call from a local repo to open the repository on github/bitbucket in browser
repo() {
  local giturl=$(git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')
  if [[ $giturl == "" ]]; then
    echo "Not a git repository or no remote.origin.url is set."
  else
    local gitbranch=$(git rev-parse --abbrev-ref HEAD)
    local giturl="http:${giturl}"

    if [[ $gitbranch != "master" ]]; then
      local giturl="${giturl}/tree/${gitbranch}"
    fi

    echo $giturl
    open $giturl
  fi
}

# Get colors in manual pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# Use feh to nicely view images
openimage() {
  local types='*.jpg *.JPG *.png *.PNG *.gif *.GIF *.jpeg *.JPEG'

  cd $(dirname "$1")
  local file=$(basename "$1")

  feh -q $types --auto-zoom \
    --sort filename --borderless \
    --scale-down --draw-filename \
    --image-bg black \
    --start-at "$file"
}

# get dbus session
dbs() {
  local t=$1
  if [[  -z "$t" ]]; then
    local t="session"
  fi

  dbus-send --$t --dest=org.freedesktop.DBus \
    --type=method_call  --print-reply \
    /org/freedesktop/DBus org.freedesktop.DBus.ListNames
}

# check if uri is up
isup() {
  local uri=$1

  if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
    notify-send --urgency=critical "$uri is down"
  else
    notify-send --urgency=low "$uri is up"
  fi
}

# build go static binary from root of project
gostatic(){
  local dir=$1

  if [[ -z $dir ]]; then
    dir=$(pwd)
  fi

  local name=$(basename "$dir")
  (
  cd $dir
  echo "Building static binary for $name in $dir"
  CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o "$name" .
  )
}

# go to a folder easily in your gopath
gogo(){
  local d=$1

  if [[ -z $d ]]; then
    echo "You need to specify a project name."
    return 1
  fi

  # search for the project dir in the GOPATH
  local path=( `find "${GOPATH}/src" -iname "$d" -type d` )

  if [[ "$path" == "" ]]; then
    echo "Could not find a directory named $d in $GOPATH"
    echo "Maybe you need to 'go get' it ;)"
    return 1
  fi

  # enter the first path found
  cd "${path[0]}"
}

# get the name of a x window
xname(){
  local window_id=$1

  if [[ -z $window_id ]]; then
    echo "Please specifiy a window id, you find this with 'xwininfo'"

    return 1
  fi

  local match_string='".*"'
  local match_int='[0-9][0-9]*'
  local match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference

  # get the name
  xprop -id $window_id | \
    sed -nr \
    -e "s/^WM_CLASS\(STRING\) = ($match_qstring), ($match_qstring)$/instance=\1\nclass=\3/p" \
    -e "s/^WM_WINDOW_ROLE\(STRING\) = ($match_qstring)$/window_role=\1/p" \
    -e "/^WM_NAME\(STRING\) = ($match_string)$/{s//title=\1/; h}" \
    -e "/^_NET_WM_NAME\(UTF8_STRING\) = ($match_qstring)$/{s//title=\1/; h}" \
    -e '${g; p}'
}
