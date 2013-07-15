# load scripts (I could loop, but having them be separate lines will make me
# know which scripts I have, since I'll never actually go to the zsh_scripts
# folder).
source ~/.zsh_scripts/spectrum.zsh

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
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

zle -N zle-line-init
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

# reverse search by default
bindkey "[A"  history-search-backward
bindkey "[B"  history-search-forward

source ~/.zshrc_local
