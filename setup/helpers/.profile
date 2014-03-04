[ -e ~/.profile_before ] && source ~/.profile_before

cd $ROOT/bash
source .profile
cd - >/dev/null

[ -e ~/.profile_after ] && source ~/.profile_after
