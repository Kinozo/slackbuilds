#!/bin/bash

set -e

module=$(basename $0 -snapshot.sh)
snaproot="svn://svn.mplayerhq.hu/nut"

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
  svn checkout ${SNAP_COOPTS} ${snaproot}/src/trunk ${module}-${snap}
  svn checkout ${SNAP_COOPTS} ${snaproot}/docs ${module}-${snap}/docs
  pushd ${module}-${snap}
    find . -type d -name .svn -print0 | xargs -0r rm -rf
  popd
  tar -Jcf "${pwd}"/${module}-${snap}.tar.bz2 ${module}-${snap}
popd >/dev/null
