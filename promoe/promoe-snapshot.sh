#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="git://git.xmms.se/xmms2/${module}.git/"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

pushd "${tmp}"
  git clone --depth 1 ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    find . -type d -name .git -print0 | xargs -0r rm -rf
    find . -type f -name .gitignore -print0 | xargs -0r rm -f
  popd
  tar Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
