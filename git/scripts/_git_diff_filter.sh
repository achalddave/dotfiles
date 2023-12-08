if type delta >/dev/null 2>&1 ; then
    if [ $CONFIG_LIGHT_COLORS -eq '1' ] ; then
        delta --color-only --syntax-theme="GitHub"
    else
        delta --color-only --syntax-theme="zenburn"
    fi
else
    # 6/15/21: diff-highlight has been removed from the diff-so-fancy repo, so
    # the below needs to be fixed. You could use diff-so-fancy --patch as
    # indicated here: https://github.com/so-fancy/diff-so-fancy/issues/401
    # but I was not able to get it to work currently.

    # Earlier note:
    # diff-so-fancy has some issues with git add --patch. For example, it shows some
    # lines from the next or previous hunks. See
    # https://github.com/so-fancy/diff-so-fancy/pull/172 .
    diff-highlight | less --tabs=4 -RFX
fi
