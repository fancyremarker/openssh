#!/bin/sh

wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssh/openssh_5.9p1-5ubuntu1.debian.tar.gz
tar xzf openssh_5.9p1-5ubuntu1.debian.tar.gz

for patchfile in $(grep '\.patch' debian/patches/series); do
  git apply --whitespace=nowarn debian/patches/${patchfile} || exit 1
done

rm openssh_5.9p1-5ubuntu1.debian.tar.gz
rm -rf debian/
