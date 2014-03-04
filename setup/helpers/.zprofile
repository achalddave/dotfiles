[ -e ~/.zprofile_before ] && source ~/.zprofile_before

cd $ROOT/zsh
source .zprofile
cd - >/dev/null

[ -e ~/.zprofile_after ] && source ~/.zprofile_after
