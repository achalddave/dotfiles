if type delta >/dev/null 2>&1 ; then
    if [ $CONFIG_LIGHT_COLORS -eq '1' ] ; then
        delta --syntax-theme="GitHub"
    else
        delta --dark --syntax-theme="zenburn"
    fi
else
    diff-so-fancy
fi
