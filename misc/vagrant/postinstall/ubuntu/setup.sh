if [ ! -e ~/.dircolors ] ; then
    # Windows folders show up with an ugly green background because they're
    # other writable; fix this
    dircolors -p | sed 's/OTHER_WRITABLE 34;42/OTHER_WRITABLE 01;34/' > ~/.dircolors
else
    echo "Dircolors already exists! Not changing."
fi
