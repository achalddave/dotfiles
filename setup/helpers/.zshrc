[ -e ~/.zshrc_before ] && source ~/.zshrc_before

pushd $ROOT/zsh > /dev/null
source .zshrc
popd > /dev/null

[ -e ~/.zshrc_after ] && source ~/.zshrc_after
