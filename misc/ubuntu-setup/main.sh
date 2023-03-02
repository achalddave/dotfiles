sudo apt-get update


# For add-apt-repository (http://askubuntu.com/questions/38021/how-to-add-a-ppa-on-a-server)
sudo apt-get --yes install python-software-properties

# Add repo for latest Ubuntu Git version
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update

sudo apt-get --yes install git
sudo apt-get --yes install vim
sudo apt-get --yes install make
sudo apt-get --yes install zsh

# Install neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

sudo apt-get install ripgrep
sudo apt-get install fd-find

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

mkdir -p ~/.local/bin/
ln -s $(which fdfind) ~/.local/bin/fd

touch ~/.zshenv
echo 'DEBIAN_PREVENT_KEYBOARD_CHANGES=yes' >> ~/.zshenv

./install_delta.sh
