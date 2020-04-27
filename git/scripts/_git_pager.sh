if type delta >/dev/null 2>&1 ; then
    delta --dark --theme="zenburn"
else
    diff-so-fancy
fi
