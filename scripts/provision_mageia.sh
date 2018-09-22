#!/bin/bash

# Are we on a supported distro? Note: We can't use dpkg-vendor
# because it is installed via `build-essential`.
grep -Ei 'mageia' /etc/*release > /dev/null || {
    echo >&2 "Run this script on a mageia host."; exit 1;
}

# Make debconf use a frontend that expects no interactive input
SCRIPT_DIR="$(dirname "$0")"

dnf -y upgrade --refresh
# dirmngr is required for gnupg2 key retrieval
dnf -y install dirmngr
dnf -y install mgarepo bm clang cmake curl \
    git gnupg2 gperf htop ninja-build python-devel \
    tmux unzip vim

# update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-5.0 100

# Install python3.6 and packages
dnf -y install python3-pip
pip3 install --no-cache-dir --disable-pip-version-check -r $SCRIPT_DIR/requirements.txt

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Dependencies for test programs #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

dnf -y install automake autoconf libtool

# lua dependencies
dnf -y install readline-devel

# lighttpd dependencies
dnf -y install 'pkgconfig(bzip2)'

# python dependencies
dnf -y install python-setuptools tcl-devel liblzma-devel libgdbm-devel
dnf -y install tk-devel

# redis and sqlite dependencies
dnf -y install tcl tcl-devel

# varnish dependencies
dnf -y install python-docutils graphviz
