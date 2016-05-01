[ -e ~/.bashrc_before ] && source ~/.bashrc_before

pushd $ROOT/bash > /dev/null
source .bashrc
popd > /dev/null

[ -e ~/.bashrc_after ] && source ~/.bashrc_after

bind -f $ROOT/bash/.inputrc
