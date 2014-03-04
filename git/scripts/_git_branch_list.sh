#!/bin/bash

function usage_print {
    echo "Usage: git brlist [<remote>|HEAD] [<remote>|HEAD]"
}

function get_canonical_remote_name {
    if [[ "$1" == "HEAD" ]] ; then
        echo "refs/heads"
    else
        echo "refs/remotes/$1"
    fi
}

function get_friendly_name {
    # Remove refs/remotes, convert refs/heads to local
    # remove them both :)
    _tmp_branch=${1#refs/remotes/}
    echo ${_tmp_branch/refs\/heads/local}
}

function echo_emph {
    echo $1
    echo `echo $1 | sed 's/./=/g'`
}

# List all branches on remote specified by $1
function one_remote_branch {
    echo_emph "Branches on "`get_friendly_name $1`
    for branch in $(git for-each-ref $1 --format='%(refname:short)') ; do
        echo $branch
    done
}

# List which branches are on remote $1 but not on $2, and vice versa
function two_remote_branches {
    echo_emph "Only on "`get_friendly_name $1`
    for branch in $(git for-each-ref $1 --format='%(refname:short)') ; do
        # remove the remote name from the branch
        branch=${branch#*/}
        git show-ref --verify --quiet $2/$branch
        if [[ $? != 0 ]] ; then
            echo -e "\t$branch"
        fi
    done

    echo_emph "Only on "`get_friendly_name $2`
    for branch in $(git for-each-ref $2 --format='%(refname:short)') ; do
        branch=${branch#*/}
        git show-ref --verify --quiet $1/$branch
        if [[ $? != 0 ]] ; then
            echo -e "\t$branch"
        fi
    done
}

function list_branch {
    if [[ $# > 3 ]] ; then
        usage_print
        exit 1
    elif [[ "$1" == "-h" || "$1" == "--help" ]] ; then
        usage_print
        exit 0
    fi

    a=${1:-HEAD}
    b=$2

    a=`get_canonical_remote_name $a`

    if [[ -z "$b" ]] ; then
        # 1 parameter
        one_remote_branch $a
    else
        b=`get_canonical_remote_name $b`
        two_remote_branches $a $b
    fi

}

list_branch $@
