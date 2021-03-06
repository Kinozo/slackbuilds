
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -d mozilla/gfx/cairo/cairo -i ${SB_PATCHDIR}/01_fix_slowness.patch
patch -p1 -E --backup  -z .vpx -d mozilla --verbose -i ${SB_PATCHDIR}/xulrunner-vpx-define.patch
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/firefox-build-prbool.patch
# Unable to install addons from https pages
patch -p2 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/rhbz-966424.patch
case "${ARCH}" in
  i[3-6]86|s390)
    patch -p2 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/firefox-baseline-disable.patch
    ;;
esac
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.29-enable-addons.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.30-installdir.patch
#patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/seamonkey-2.25-elfhack.patch

# Upstream patches
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-858919.patch

# Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.30-pulseaudio_configure_switch_fix.patch

# OpenSUSE
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-nongnome-proxies.patch
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-icu-strncat.patch
patch -p1 -E --backup --verbose -d mozilla -i ${SB_PATCHDIR}/mozilla-bmo1088588.patch

set +e +o pipefail
