  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.3.75-template.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-X11.patch.gz | patch -p1 -E --backup --verbose || exit 1