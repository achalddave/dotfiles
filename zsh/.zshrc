source ~/.zsh_scripts/spectrum.zsh

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle :compinstall filename '/Users/achal/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_hist
HISTSIZE=10000
SAVEHIST=20000
setopt autocd extendedglob
unsetopt beep
# End of lines configured by zsh-newuser-install

# laziness
alias l='ls'
alias la='ls -A'
alias g='git'
alias py='python'
alias so='source'

# Changing/making/removing directory
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -- -='cd -'
alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'

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

# set_prompt
autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla
zstyle ':vcs_info:git*' formats '(%b) '

precmd() { vcs_info }

setopt prompt_subst
PS1='%{$FG[245]%}%m:%{$FG[255]%}%~%{$FG[155]%} ${vcs_info_msg_0_}%{$FG[196]%}~%{$reset_color%} '

bindkey "[A"  history-search-backward
bindkey "[B"  history-search-forward

source ~/.zshrc_local
