#!/bin/bash

set -e

module=fusion-icon
snaproot="git://anongit.opencompositing.org/users/crdlb/${module}"

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
  git clone ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    find . -type d -name .git -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null

