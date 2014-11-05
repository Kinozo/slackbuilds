
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_VERBOSE_OPT
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch -p1 -s -F1 --backup ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/udev-microsoft-3000-keymap.patch
# From Slackware
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/60-cdrom_id.rules.diff

# Upstream
ApplyPatch 0001-nspawn-ignore-EEXIST-when-creating-mount-point.patch
ApplyPatch 0001-sd-dhcp-client-clean-up-raw-socket-sd_event_source-w.patch
ApplyPatch 0001-shared-install-avoid-prematurely-rejecting-missing-u.patch
ApplyPatch 0001-sd-bus-properly-handle-removals-of-non-existing-matc.patch
ApplyPatch 0001-units-don-t-order-journal-flushing-afte-remote-fs.ta.patch
ApplyPatch 0001-units-order-sd-journal-flush-after-sd-remount-fs.patch
ApplyPatch 0001-units-make-systemd-journald.service-Type-notify.patch

### Fedora
ApplyPatch fedora-disable-resolv.conf-symlink.patch

### Arch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
