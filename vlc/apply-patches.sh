
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/vlc-2.1.5-ffmpeg56.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vlc-1.1.10-default_font.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/320_all_cachegen.patch

### Mageia
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/vlc-2.0.4-fix-definition.patch

set +e +o pipefail
