# load scripts (I could loop, but having them be separate lines will make me
# know which scripts I have, since I'll never actually go to the zsh_scripts
# folder).
source ~/.zsh_scripts/spectrum.zsh

# currently this is giving some errors I couldn't care less about
# use git's git completion, not zsh's (with zsh, git alias arguments don't get
# tab completed for some reason)
source ~/.zsh_scripts/git-completion.zsh 2>/dev/null

# turn on correction 
setopt correctall

# Completion
autoload -Uz compinit
compinit

# Git file completion is super slow; this should fix it
# http://stackoverflow.com/questions/9810327/
__git_files () { 
    _wanted files expl 'local files' _files     
}

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' 'r:[^A-Z0-9]||[A-Z0-9]=** r:|=*' 

# 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
zstyle :compinstall filename '/Users/achal/.zshrc'
zstyle ':completion:*' menu select=2

# vim!
KEYTIMEOUT=0.15
autoload edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line
bindkey 'kj' vi-cmd-mode
# see http://www.zsh.org/mla/users/2009/msg00812.html
# Otherwise you can't backspace things you didn't just insert
bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char

# cyan color in vim mode
function zle-line-init zle-keymap-select {
    if [[ "$KEYMAP" == 'vicmd' ]] ; then
        PS1="$PS1%{$fg[cyan]%}"
    elif [[ "$PS1" =~ ".*$fg\[cyan\]" ]] ; then
        PS1=${PS1/"$fg[cyan]"/}
    fi
    zle reset-prompt
}

# reset cyan on enter
function zle-line-finish {
    if [[ "$PS1" =~ ".*$fg\[cyan\]" ]] ; then
        PS1=${PS1/"$fg[cyan]"/}
    fi
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# history
HISTFILE=~/.zsh_hist
HISTSIZE=10000
SAVEHIST=20000

# please don't beep
unsetopt beep

# laziness
alias l='ls'
alias la='ls -A'
alias g='git'
alias py='python'
alias so='source'

# swap two files (not directories!)
function swap() {
    if [[ "$#" -lt 2 ]] || [[ ! -f "$1" ]] || [[ ! -f "$2" ]]; then
        if [[ -d "$1" ]] || [[ -d "$2" ]] ; then
            echo "You can't swap two directories right now."
        else
            echo "swap [file1] [file2]"
        fi
        return 1
    fi

    mydir=$(dirname "$1");
    if type mktemp > /dev/null ; then
        tmpfile=$(mktemp "$mydir"/XXXXXX)
    else
        tmpfile="/tmp/$mydir"
    fi

    mv "$1" "$tmpfile"
    mv "$2" "$1"
    mv "$tmpfile" "$2"
}

# Changing/making/removing directory
setopt autocd extendedglob
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# directory laziness
alias -- -='cd -'
alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

# colors!
if [[ `uname` == "Linux" ]]
then
    alias ls='ls --color=always'
else
if [[ `uname` == "Darwin" ]]
then
    alias ls='ls -G'
fi
fi
alias grep='grep --color=tty'

# safety
setopt noclobber
alias cp='cp -i'
alias mv='mv -i'

# prompt and colors
autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla
zstyle ':vcs_info:git*' formats '(%b) '

precmd() { vcs_info }

setopt prompt_subst
PS1='%{$FG[245]%}%m:%{$FG[255]%}%~%{$FG[155]%} ${vcs_info_msg_0_}%{$FG[196]%}~%{$reset_color%} '

if [[ "$TERM" == "screen" ]] ; then
    export TERM=screen-256color-bce
fi

# FIX FOR ZSH HISTORY CURSOR 
# This should work exactly as bash's history-search-[back|for]ward
#   i.e. if you have an empty line and hit <Up>, your cursor will go to the end of line
#        if you have some letters and hit <Up>, your cursor will stay where it was and 
#        zsh will fill the rest of the line with the history search.
#
# Much of this function taken from http://www.zsh.org/mla/users/1999/msg00555.html
function history-search-end {
    integer ocursor=$CURSOR

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
      # Last widget called set $hbs_pos.
      CURSOR=$hbs_pos
    else
      hbs_pos=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
      # if we started at front, go to end of line
      if [ $CURSOR -eq 0 ] ; then
          zle .end-of-line
      else
          # otherwise, keep cursor where it was
          CURSOR=$hbs_pos
      fi
    else
      # failure, restore position
      CURSOR=$ocursor
      return 1
    fi
}
autoload -U history-beginning-search-backward-end
autoload -U history-beginning-search-forward-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "[A" history-beginning-search-backward-end
bindkey "[B" history-beginning-search-forward-end

source ~/.zshrc_local
