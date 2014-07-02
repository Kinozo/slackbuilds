
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-20120731-pdf-filters.patch

### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/giflib.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
