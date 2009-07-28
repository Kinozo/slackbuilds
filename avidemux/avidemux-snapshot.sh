#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="svn://svn.berlios.de/avidemux/branches/${module}_2.4_branch"

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
  set +e
  [ -z "${tmp}" -o ! -d "${tmp}" ] || rm -rf "${tmp}"
}

unset CDPATH
pwd=$(pwd)
snap=${snap:-$(date +%Y%m%d)}

[ "${snap}" = "$(date +%Y%m%d)" ] || SNAP_COOPTS="-r {$snap}"

pushd "${tmp}"
  svn checkout ${SNAP_COOPTS} ${snaproot} ${module}-${snap}
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd >/dev/null
  tar -Jcf "${pwd}"/${module}-${snap}.tar.xz ${module}-${snap}
popd >/dev/null
