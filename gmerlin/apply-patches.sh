
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .libdir --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.3-libdir.patch

set +e +o pipefail
