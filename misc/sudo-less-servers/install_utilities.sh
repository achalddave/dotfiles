# Helper utility for installing various tools locally when you don't have sudo
# and work in a controlled environment with old software.
#
# Installs:
#   * wget
#   * autoconf
#   * zsh
#   * git
#   * tmux
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

# Exit on error.
set -e

mkdir -p ${SCRATCH_DIR}
mkdir -p ${LOCAL_INSTALL_DIR}

# Usage: untar_to_dir <tar_file> <output_directory>
# Untars to a specified directory, instead of using the "root" directory
# specified in the tar file. Useful for cd'ing.
untar_to_dir() {
    if [[ "$#" -ne 2 ]] ; then
        echo "Not enough arguments to untar_to_dir"
        exit
    fi

    TAR_FILE="${1}"
    OUTPUT="${2}"
    mkdir -p "${OUTPUT}"

    tar xzvf "${TAR_FILE}" -C "${OUTPUT}" --strip-components=1
}

# Update wget; the current version can't deal with SSL on Github properly.
install_wget() {

    cd ${SCRATCH_DIR}
    mkdir -p wget
    cd wget

    wget "http://ftp.gnu.org/gnu/wget/wget-${WGET_VERSION}.tar.gz"
    untar_to_dir "wget-${WGET_VERSION}tar.gz" "wget-${WGET_VERSION}"
    cd "wget-${WGET_VERSION}"

    ./configure --prefix=${LOCAL_INSTALL_DIR} --with-ssl=openssl

    cd ${SCRATCH_DIR}
}

install_git() {
    cd ${SCRATCH_DIR}

    mkdir -p git
    cd git

    wget "https://github.com/git/git/archive/v${GIT_VERSION}.tar.gz"
    untar_to_dir "v${GIT_VERSION}.tar.gz" "git-${GIT_VERSION}"
    cd "git-${VERSION}"

    make configure
    ./configure --prefix="${LOCAL_INSTALL_DIR}"
    make -j4 all info
    make install

    cd ${SCRATCH_DIR}
}

install_tmux() {
    TMUX_INSTALL_SCRIPT="https://gist.githubusercontent.com/achalddave/c13a010c0365e1ac97e7/raw/8bafa2065ac349ae4fd6118da47454a21d5be4f1/tmux_local_install.sh"

    cd ${SCRATCH_DIR}
    mkdir -p tmux
    cd tmux

    wget ${TMUX_INSTALL_SCRIPT} -O tmux_local_install.sh
    chmod +x tmux_local_install.sh
    ./tmux_local_install.sh
}

install_autoconf() {
    # Can be a version, or "latest".

    cd ${SCRATCH_DIR}
    mkdir -p autoconf
    cd autoconf

    wget "http://ftp.gnu.org/gnu/autoconf/autoconf-${AUTOCONF_VERSION}.tar.gz"
    untar_to_dir "autoconf-${AUTOCONF_VERSION}.tar.gz" "autoconf-${AUTOCONF_VERSION}"
    cd "autoconf-${AUTOCONF_VERSION}"

    ./configure --prefix="${LOCAL_INSTALL_DIR}"
    make -j4
    make install
}

install_zsh() {

    cd ${SCRATCH_DIR}
    mkdir -p zsh
    cd zsh

    wget "http://downloads.sourceforge.net/project/zsh/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.gz"
    untar_to_dir "zsh-${ZSH_VERSION}.tar.gz" "zsh-${ZSH_VERSION}"
    cd "zsh-${ZSH_VERSION}"

    ./configure --prefix="${LOCAL_INSTALL_DIR}"
    make -j4
    make install
}

install_wget
install_git
install_tmux
install_autoconf
install_zsh
