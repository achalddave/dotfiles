#!/bin/bash

set -e

SCRATCH_DIR=${HOME}/scratch/
INSTALL_DIR=${HOME}/local

TMUX_VERSION=2.8
TMUX_URL=https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
TMUX_SCRATCH=${SCRATCH_DIR}/tmux-${TMUX_VERSION}

LIBEVENT_VERSION=2.0.22
LIBEVENT_URL=https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
LIBEVENT_SCRATCH=${SCRATCH_DIR}/libevent-2.0.22

# If you change this, also change NCURSES_URL
NCURSES_VERSION=5.9
NCURSES_URL=ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
NCURSES_SCRATCH=${SCRATCH_DIR}/ncurses-5.9

mkdir -p ${LIBEVENT_SCRATCH}
mkdir -p ${NCURSES_SCRATCH}
mkdir -p ${TMUX_SCRATCH}

echo "Downloading files"
# The libevent URL was updated to not require an SSL handshake (and to use a
# more recent version).

# wget -O ${LIBEVENT_SCRATCH}/libevent-${LIBEVENT_VERSION}.tar.gz ${LIBEVENT_URL}
# wget -O ${NCURSES_SCRATCH}/ncurses-${NCURSES_VERSION}.tar.gz ${NCURSES_URL}
# wget -O ${TMUX_SCRATCH}/tmux-${TMUX_VERSION}.tar.gz ${TMUX_URL}

############
# libevent #
############
cd ${LIBEVENT_SCRATCH}
echo "==="
echo "Setting up libevent: ${LIBEVENT_VERSION}"
echo "==="
tar xvzf libevent-${LIBEVENT_VERSION}.tar.gz --strip-components=1
./configure --prefix=${INSTALL_DIR}/libevent-${LIBEVENT_VERSION} --disable-shared
make
make install
LIBEVENT_INCLUDE="${INSTALL_DIR}/libevent-${LIBEVENT_VERSION}/include/"
LIBEVENT_LIB="${INSTALL_DIR}/libevent-${LIBEVENT_VERSION}/lib/"

###########
# ncurses #
###########
cd ${NCURSES_SCRATCH}
echo "==="
echo "Setting up ncurses: ${NCURSES_VERSION}"
echo "==="
tar xvzf ncurses-${NCURSES_VERSION}.tar.gz --strip-components=1
# I needed to add --enable-shared for an unrelated install
# (namely, gnureadline through pip install ipython[all])
# CPPFLAGS: https://stackoverflow.com/questions/37475222/ncurses-6-0-compilation-error-error-expected-before-int
CPPFLAGS="-P" ./configure --prefix=${INSTALL_DIR}/ncurses-${NCURSES_VERSION} --enable-shared
make
make install
NCURSES_INCLUDE="${INSTALL_DIR}/ncurses-${NCURSES_VERSION}/include/"
NCURSES_LIB="${INSTALL_DIR}/ncurses-${NCURSES_VERSION}/lib/"

########
# tmux #
########
echo "==="
echo "Setting up tmux: ${TMUX_VERSION}"
echo "==="
cd ${TMUX_SCRATCH}
# tar xzvf tmux-${TMUX_VERSION}.tar.gz --strip-components=1
echo ${NCURSES_INCLUDE}
export C_INCLUDE_PATH="${C_INCLUDE_PATH}:${NCURSES_INCLUDE}:${LIBEVENT_INCLUDE}"
export CXX_INCLUDE_PATH="${CXX_INCLUDE_PATH}:${NCURSES_INCLUDE}:${LIBEVENT_INCLUDE}"
export LDFLAGS="-L${NCURSES_LIB} -L${LIBEVENT_LIB}"
./configure --prefix=${INSTALL_DIR}/tmux-${TMUX_VERSION} \
    LIBTINFO_CFLAGS="-I${NCURSES_INCLUDE}/ncurses" \
    LIBTINFO_LIBS="-lncurses"
CFLAGS="-I${NCURSES_INCLUDE} -I${LIBEVENT_INCLUDE}" \
CPPFLAGS="-I${NCURSES_INCLUDE} -I${LIBEVENT_INCLUDE}" \
CXXFLAGS="-I${NCURSES_INCLUDE} -I${LIBEVENT_INCLUDE}" \
    make
make install

echo "${INSTALL_DIR}/tmux-${TMUX_VERSION}/bin/tmux is now available."
