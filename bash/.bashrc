# laziness
alias l='ls'
alias la='ls -A'
alias g='git'
alias py='python'
alias ..='cd ..'
# maintain git tab completion with g
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
        || complete -o default -o nospace -F _git g
alias so='source'

if [[ `uname` == "Linux" ]] || [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]] || [[ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]]
then
    alias ls='ls --color=always'
else
if [ `uname` == "Darwin" ]
then
    alias ls='ls -G'
    alias grep='grep --color=tty'
fi
fi

set EDITOR=vim
export EDITOR

function set_prompt {
  local       BLACK="\[\033[0;30m\]"
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"

export PS1=$LIGHT_GRAY'\h:\w `git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'$LIGHT_RED'~ '$WHITE
export PS2='>'
}

set_prompt

function cd() {
  if [[ $@ == "..l" ]] ; then command cd ..;l ; else command cd "$@" ; fi
}
