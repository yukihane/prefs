#!/bin/bash -eux

git_ver=git-2.21.0
# Dockerイメージにはsudoが無い、かつrootでセットアップしている前提なので
sudo=$(command -v sudo)

${sudo} yum -y install xz gcc autoconf make zlib-devel curl-devel expat-devel gettext-devel openssl-devel perl-devel

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
