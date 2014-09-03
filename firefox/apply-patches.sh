
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Build patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-install-dir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-enable-addons.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-duckduckgo.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/toolkit-download-folder.patch

# Upstream patches

### OpenSUSE
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/firefox-branded-icons.patch

# OpenSuse kde integration support
if [ "${SB_KDE}" = "YES" ] ;then
  patch -p1 -E --backup -z .fx-kde --verbose -i ${SB_PATCHDIR}/mozilla-kde.patch
  patch -p1 -E --backup -z .fx-kde --verbose -i ${SB_PATCHDIR}/firefox-kde.patch
fi

set +e +o pipefail
