[ -e ~/.zprofile_before ] && source ~/.zprofile_before

pushd $ROOT/zsh > /dev/null
source .zprofile
popd > /dev/null

[ -e ~/.zprofile_after ] && source ~/.zprofile_after
