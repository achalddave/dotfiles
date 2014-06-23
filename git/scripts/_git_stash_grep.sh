#!/bin/bash
# Grep through your the contents of all your stashes for a given pattern.
#
# Ideally, this could simply be a flag to an existing command, a la
# `git log -S` or `git log -G`...
#
# Slightly modified from https://gist.github.com/hartym/2584767
#
# Ideally, this would use git plumbing commands, but I can't find any that work
# with the stash.

set -e

function usage_print {
    echo "Usage: git stashgrep [grep-flags] <pattern>"
}

function stash_grep_raw {
    for i in `git stash list --format="%gd"` ; do
        git stash show -p $i | grep -H --color=always --label="$i" $@ \
            || true
    done
}

function stash_grep {
    if [ -z "$1" ] ; then
        usage_print >&2
        exit 1
    fi
    if [[ "$1" == "--help" || "$1" == "-h" ]] ; then
        usage_print
        exit 0
    fi
    stash_grep_raw $@
}

stash_grep $@
