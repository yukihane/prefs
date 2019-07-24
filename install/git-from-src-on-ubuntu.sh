#!/bin/bash -eux

git_ver=git-2.22.0
# Dockerイメージにはsudoが無い、かつrootでセットアップしている前提なので
sudo=$(command -v sudo)

${sudo} apt -y install gcc make autoconf zlib1g-dev libcurl4-openssl-dev libexpat1-dev libssl-dev gettext

pushd /tmp
curl -L -o git-src.tar.xz https://mirrors.edge.kernel.org/pub/software/scm/git/${git_ver}.tar.xz
tar xf git-src.tar.xz
cd ${git_ver}

make configure
./configure --prefix=/usr/local
make

${sudo} make install

cd ..
rm -rf git-src.tar.xz ${git_ver}
unset git_ver
unset sudo
popd
