if type delta >/dev/null 2>&1 ; then
    if [ $CONFIG_LIGHT_COLORS -eq '1' ] ; then
        delta --theme="GitHub"
    else
        delta --dark --theme="zenburn"
    fi
else
    diff-so-fancy
fi
