# end berkeley settings, start my settings
alias ls='ls --color=always'
alias l='ls'
alias la='ls -a'
alias g='git'
# maintain git tab completion with g
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
        || complete -o default -o nospace -F _git g

alias so='source'

if [ `uname` == "Linux" ]
then
    alias ls='ls --color=always'
fi

set EDITOR=vim
export EDITOR

function check_submission {
    rm -rf ~/tmp_check_submission;
    mkdir ~/tmp_check_submission;
    cd ~/tmp_check_submission;
    git init;
    git remote add origin ~cs61c/git/repos/cs61c-kg;
    git pull origin $1;
    read -p "Press [Enter] to continue";
    cd ~;
    #rm -rf ~/tmp_check_submission;
}

function set_prompt {
  local       BLACK="\[\033[0;30m\]"
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"

export PS1=$LIGHT_GRAY'\w `git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'$LIGHT_RED'~ '$WHITE
export PS2='>'
}

set_prompt

source ~/.bashrc_local
