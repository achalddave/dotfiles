# Available configurations; set from ~/.zshrc_before
# has_256 (default True)
has_256=${has_256:-1}

# load scripts (I could load them all at once, but having them be separate
# lines will make me know which scripts I have, since I'll never actually go to
# the zsh_scripts folder).
if [ "$has_256" -eq 1 ] ; then
    # Most Windows terminals don't support 256 colors
    source scripts/spectrum.zsh
fi

# Use git's git completion, not zsh's (with zsh, git alias arguments don't get
# tab completed for some reason)
source scripts/git-completion.zsh 2>/dev/null

# turn on correction 
setopt correctall

# Completion
autoload -Uz compinit
compinit

# Bash style word selection
#   e.g. ctrl-w should kill backwards up to a slash
autoload -U select-word-style
select-word-style bash


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

# Key mappings

# Vim
# When I hit <kj>, I want to stay at my current position (that is, if I hit
# <i> right after, I want to be at the same place). By default, Vim would
# move you one to the left. This does the same thing as:
#   nnoremap kj <Esc>l
# This function takes care of doing this, and 'kj' is later bound to it.
function vi-cmd-mode-forward-fn { zle vi-cmd-mode ; zle vi-forward-char }
zle -N vi-cmd-mode-forward vi-cmd-mode-forward-fn

bindkey -v
KEYTIMEOUT=15
autoload edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line
bindkey -M viins 'kj' vi-cmd-mode-forward # See comment above vi-cmd-mode-forward-fn.
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo


# See http://www.zsh.org/mla/users/2009/msg00812.html.
# Otherwise you can't backspace things you didn't just insert.
bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char

bindkey "[A" history-beginning-search-backward-end
bindkey "[B" history-beginning-search-forward-end
bindkey -M vicmd 'k' history-beginning-search-backward-end
bindkey -M vicmd 'j' history-beginning-search-forward-end

# cyan color in vim mode
function zle-line-init zle-keymap-select {
    if [[ "$KEYMAP" == 'vicmd' ]] ; then
        PROMPT="$PROMPT%{$fg[cyan]%}"
    else
        PROMPT=${PROMPT%%"%{$fg[cyan]%}"}
    fi
    zle reset-prompt
    zle -R
}

# reset cyan on enter
function zle-line-finish {
    PROMPT=${PROMPT%%"%{$fg[cyan]%}"}
    zle reset-prompt
    zle -R
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

# Go up k times
function up() {
    if [[ "$#" -lt 1 ]] ; then
        echo "Usage: up [num_directories]"
        return 1
    fi
    # We could cd .. multiple times, but this pollutes the directory stack.
    dir_path=''
    for i in $(seq $1) ; do
        dir_path="../${dir_path}"
    done
    cd $dir_path
}

# Changing/making/removing directory
setopt autocd extendedglob
# Removing because of issue with autojump:
#   https://github.com/joelthelion/autojump/issues/312
# setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# laziness
# colors!
if [[ `uname` == "Darwin" ]]
then
    alias ls='ls -G'
elif [[ `uname` == "Linux" ]] ||
     [[ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]] ||
     [[ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]]
then
    alias ls='ls --color=always -p'
fi

alias c='cd'
alias grep='grep --color=tty'
alias l='ls -p'
alias la='ls -Ap'
alias ll='ls -Alhp'
alias g='git'
alias py='python'
alias so='source'
function sa () {
    if [[ "$#" < 1 || ("$1" != "-f" && "$1" != "--force" ) ]] ; then
        if [ -n "$SSH_AUTH_SOCK" ] ; then
            echo "You already seem to have an SSH agent running."
            echo "Pass [-f|--force] to override this."
            return 1
        fi
    fi
    eval `ssh-agent`
    ssh-add
}

function sockd () {
    echo $SSH_AUTH_SOCK > "/tmp/achal-ssh-sock-$(date +%3N)"
    echo $DISPLAY > "/tmp/achal-display-$(date +%3N)"
}

function socku () {
    export SSH_AUTH_SOCK=$(cat $(/bin/ls -dt /tmp/achal-ssh-sock-* | head -1))
    export DISPLAY=$(cat $(/bin/ls -dt /tmp/achal-display-* | head -1))
}

# directory laziness
alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

# safety
setopt noclobber
alias cp='cp -i'
alias mv='mv -i'

# prompt and colors
autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '(%b) '

precmd() { vcs_info }

setopt prompt_subst
if [ "$has_256" -eq 1 ] ; then
    PROMPT=$'%{$FG[243]%}%* | %m'$'\n''%{$FG[255]%}%~%{$FG[155]%} ${vcs_info_msg_0_}%{$FG[196]%}~%{$reset_color%} '
else
    PROMPT='%{$fg_bold[black]%}%m%{$fg_bold[white]%}:%~ %{$fg[green]%}${vcs_info_msg_0_}%{$fg[red]%}~%{$fg_bold[white]%} '
fi

if [[ "$TERM" == "screen" ]] ; then
    export TERM=screen-256color-bce
fi

# load any specific dircolors if necessary
[[ -e ~/.dircolors ]] && eval "$(dircolors ~/.dircolors)"

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

# better diff (TODO: share this with bash)
function dff() {
    diff -u "$@" | \
        sed 's/^-/\x1b[31m-/;s/^+/\x1b[32m+/;s/^@/\x1b[34m@/;s/$/\x1b[0m/' | less -R
}

[[ -d ~/.zsh/functions ]] && fpath=( ~/.zsh/functions $fpath)
