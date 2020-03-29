FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEPENDS += " bc-native dtc-native swig-native python3-native flex-native bison-native "
DEPENDS_append_sun50i = " atf-sunxi "

COMPATIBLE_MACHINE = "(sun4i|sun5i|sun7i|sun8i|sun50i)"

DEFAULT_PREFERENCE_sun4i="1"
DEFAULT_PREFERENCE_sun5i="1"
DEFAULT_PREFERENCE_sun7i="1"
DEFAULT_PREFERENCE_sun8i="1"
DEFAULT_PREFERENCE_sun50i="1"

SRC_URI += " \
           file://0001-nanopi_neo_air_defconfig-Enable-eMMC-support.patch \
           file://0020-sunxi-call-fdt_fixup_ethernet-again-to-set-macaddr-f.patch \
           file://0021-adjust-default-dram-clockspeeds.patch \
           file://0022-enable-autoboot-keyed.patch \
           file://0023-enable-DT-overlays-support.patch \
           file://0024-enable-r_pio-gpio-access-h3-h5.patch \
           file://0025-fdt-setprop-fix-unaligned-access.patch \
           file://0026-h3-enable-power-led.patch \
           file://0027-h3-Fix-PLL1-setup-to-never-use-dividers.patch \
           file://0028-h3-set-safe-axi_apb-clock-dividers.patch \
           file://0029-lower-default-DRAM-freq-A64-H5.patch \
           file://0030-sun8i-set-machid.patch \
           file://0031-fix-missing-clock-cells-in-rtc-sunxi-h3-h5.patch \
           file://boot.cmd \
           "

UBOOT_ENV_SUFFIX = "scr"
UBOOT_ENV = "boot"

EXTRA_OEMAKE += ' HOSTLDSHARED="${BUILD_CC} -shared ${BUILD_LDFLAGS} ${BUILD_CFLAGS}" '
EXTRA_OEMAKE_append_sun50i = " BL31=${DEPLOY_DIR_IMAGE}/bl31.bin "

do_compile_sun50i[depends] += "atf-sunxi:do_deploy"

do_compile_append() {
    ${B}/tools/mkimage -C none -A arm -T script -d ${WORKDIR}/boot.cmd ${WORKDIR}/${UBOOT_ENV_BINARY}
}
