
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1-0.95.1-ImplicitDSOLinking.patch
patch -p4 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95.1-gcc45.patch

set +e +o pipefail