if type delta >/dev/null 2>&1 ; then
    if [ $CONFIG_LIGHT_COLORS -eq '1' ] ; then
        delta --features="GitHub"
    else
        delta --dark --features="zenburn"
    fi
else
    diff-so-fancy
fi
