DESCRIPTION = "ARM Trusted Firmware Allwinner"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://license.rst;md5=1dd070c98a281d18d9eefd938729b031"

SRC_URI = "git://github.com/ARM-software/arm-trusted-firmware;branch=master"
SRCREV = "21e22c74cd072c878a31e41fd96a4cd1c1048cfc"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

COMPATIBLE_MACHINE = "(sun50i)"

PLATFORM_sun50i = "sun50i_a64"

LDFLAGS[unexport] = "1"

do_compile() {
    oe_runmake -C ${S} BUILD_BASE=${B} \
      CROSS_COMPILE=${TARGET_PREFIX} \
      PLAT=${PLATFORM} \
      bl31 \
      all
}

do_install() {
    install -D -p -m 0644 ${B}/${PLATFORM}/release/bl31.bin ${DEPLOY_DIR_IMAGE}/bl31.bin
}
