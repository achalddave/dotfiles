#!/bin/bash

checkout_and_notify_stashed() {
    # Warn if there are stashed changes on this branch
    git checkout "$@"
    branch=$(git rev-parse --abbrev-ref HEAD)
    stashes=$(git stash list | grep "$branch")
    RED='\033[0;31m'
    RESET='\033[0m'

    if [ -n "$stashes" ]; then
        echo "==="
        echo -e "${RED}Warning${RESET}: You have stashed changes on branch $branch"
        git stash list | grep "$branch"
        echo "==="
    fi
}

# Call the function with all provided arguments
checkout_and_notify_stashed "$@"
