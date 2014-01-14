[ -e ~/.bashrc_before ] && source ~/.bashrc_before

cd $ROOT/bash
source .bashrc
cd - >/dev/null

[ -e ~/.bashrc_after ] && source ~/.bashrc_after

bind -f $ROOT/bash/.inputrc
