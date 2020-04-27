if type delta >/dev/null 2>&1 ; then
    delta --color-only --theme="zenburn"
else
    # diff-so-fancy has some issues with git add --patch. For example, it shows some
    # lines from the next or previous hunks. See
    # https://github.com/so-fancy/diff-so-fancy/pull/172 .
    # diff-so-fancy
    diff-highlight | less --tabs=4 -RFX
fi
