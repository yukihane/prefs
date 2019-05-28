#!/bin/bash
# CentOS6 の Box に tmux を install する

set -eux

tmux_ver=2.9a
# Dockerイメージにはsudoが無い、かつrootでセットアップしている前提なので
sudo=$(command -v sudo)

${sudo} yum install -y gcc make autoconf libevent2-devel ncurses-devel
# nss が古いとcurlが失敗する(bentoイメージなど)
${sudo} yum update -y curl nss
mkdir /tmp/tmux
pushd /tmp/tmux
curl -L -O https://github.com/tmux/tmux/releases/download/${tmux_ver}/tmux-${tmux_ver}.tar.gz
tar xf tmux-${tmux_ver}.tar.gz
cd tmux-${tmux_ver}
./configure --prefix=/usr/local
make
${sudo} make install
cd /tmp && rm -rf tmux
popd
