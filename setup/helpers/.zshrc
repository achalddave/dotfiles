[ -e ~/.zshrc_before ] && source ~/.zshrc_before

cd $ROOT/zsh
source .zshrc
cd - > /dev/null

[ -e ~/.zshrc_after ] && source ~/.zshrc_after
