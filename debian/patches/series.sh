#!/bin/sh

for patchfile in $(grep '\.patch' debian/patches/series); do
  git apply --whitespace=nowarn debian/patches/${patchfile} || exit 1
done
