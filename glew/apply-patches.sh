
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .jx --verbose -i ${SB_PATCHDIR}/glew-1.11.0-makefile.patch

set +e +o pipefail
