# Helper utility for installing various tools locally when you don't have sudo
# and work in a controlled environment with old software.
#
# Installs:
#   * wget
#   * autoconf
#   * zsh
#   * git
#   * tmux
#   * python2
#
# Note that I needed to install autoconf first before I could compile zsh (I had
# an old version of autoconf).

# Where your software will be installed.
LOCAL_INSTALL_DIR="${HOME}/local"
# Temporary scratch directory for downloading/unpacking/compiling tools.
SCRATCH_DIR="${HOME}/scratch_for_setup"

# Versions
WGET_VERSION="1.16.3"
GIT_VERSION="2.6.1"
TMUX_VERSION="2.0"
AUTOCONF_VERSION="latest" # Can be "latest"
ZSH_VERSION="latest" # Can be "latest"
PYTHON_VERSION="2.7.10"

# E.g. 2.7.10 -> python2.7
PYTHON_BINARY="python$(echo $PYTHON_VERSION | sed -e 's/\([0-9]*\.[0-9]*\)\(\..*\)\?/\1/g')"

# Exit on error.
set -e

mkdir -p ${SCRATCH_DIR}
mkdir -p ${LOCAL_INSTALL_DIR}

# Usage: untar_to_dir <tar_file> <output_directory>
# Untars to a specified directory, instead of using the "root" directory
# specified in the tar file. Useful for cd'ing.
untar_to_dir() {
    if [[ "$#" -ne 2 ]] ; then
        echo "Improper number of arguments to untar_to_dir"
        exit
    fi

    TAR_FILE="${1}"
    OUTPUT="${2}"
    mkdir -p "${OUTPUT}"

    tar xzvf "${TAR_FILE}" -C "${OUTPUT}" --strip-components=1
}

# Usage: scratch_init <utility_name>
scratch_init() {
    if [[ "$#" -ne 1 ]] ; then
        echo "Improper number of arguments to scratch_init"
        exit
    fi

    cd "${SCRATCH_DIR}"
    mkdir -p "$1"
    cd "$1"
}

# Update wget; the current version can't deal with SSL on Github properly.
install_wget() {
    scratch_init wget

    wget "http://ftp.gnu.org/gnu/wget/wget-${WGET_VERSION}.tar.gz"
    untar_to_dir "wget-${WGET_VERSION}.tar.gz" "wget-${WGET_VERSION}"
    cd "wget-${WGET_VERSION}"

    ./configure --prefix=${LOCAL_INSTALL_DIR} --with-ssl=openssl
}

install_git() {
    scratch_init git

    wget "https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz" -O v${GIT_VERSION}.tar.gz
    untar_to_dir "v${GIT_VERSION}.tar.gz" "git-${GIT_VERSION}"
    cd "git-${GIT_VERSION}"

    make configure
    ./configure --prefix="${LOCAL_INSTALL_DIR}"
    make -j4 all info
    make install
}

install_tmux() {
    TMUX_INSTALL_SCRIPT="https://gist.githubusercontent.com/achalddave/c13a010c0365e1ac97e7/raw/8bafa2065ac349ae4fd6118da47454a21d5be4f1/tmux_local_install.sh"

    scratch_init tmux

    wget ${TMUX_INSTALL_SCRIPT} -O tmux_local_install.sh
    chmod +x tmux_local_install.sh
    ./tmux_local_install.sh
}

install_autoconf() {
    scratch_init autoconf

    wget "http://ftp.gnu.org/gnu/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz"
    untar_to_dir "autoconf-${AUTOCONF_VERSION}.tar.gz" "autoconf-${AUTOCONF_VERSION}"
    cd "autoconf-${AUTOCONF_VERSION}"

    ./configure --prefix="${LOCAL_INSTALL_DIR}"
    make -j4
    make install
}

install_zsh() {
    scratch_init zsh

    wget "http://downloads.sourceforge.net/project/zsh/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.gz"
    untar_to_dir "zsh-${ZSH_VERSION}.tar.gz" "zsh-${ZSH_VERSION}"
    cd "zsh-${ZSH_VERSION}"

    ./configure --prefix="${LOCAL_INSTALL_DIR}"
    make -j4
    make install

    echo "You should add the following lines to your .zshrc: "
    echo 'fpath=('
    echo ${LOCAL_INSTALL_DIR}/share/zsh/site-functions/
    echo ${LOCAL_INSTALL_DIR}/share/zsh/5.1.1/functions/
    echo '"${fpath[@]}"'
    echo ')'
}

install_python2() {
    scratch_init python2

    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz
    untar_to_dir "Python-${PYTHON_VERSION}.tgz" "python-${PYTHON_VERSION}"

    cd "python-${PYTHON_VERSION}"
    ./configure --prefix="${LOCAL_INSTALL_DIR}"
    make -j4
    make altinstall
}

install_pip() {
    scratch_init pip2

    wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    ${PYTHON_BINARY} get-pip.py
}

install_vim() {
    echo "Note: Installing vim requires that install_python2 has already been run!"
    scratch_init vim

    git clone https://github.com/vim/vim.git
    cd vim
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --with-python-config-dir=${LOCAL_INSTALL_DIR}/lib/python${PYTHON_VERSION}/config \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-cscope --prefix=${LOCAL_INSTALL_DIR}
    make -j4
    make install
}

install_wget
install_git
install_tmux
install_autoconf
install_zsh
install_vim
install_python2

echo "You should add the following line to your .zshrc/.bashrc"
echo 'PATH="'${LOCAL_INSTALL_DIR}'/bin:${PATH}"'
