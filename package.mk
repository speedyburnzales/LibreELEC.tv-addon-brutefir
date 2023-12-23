PKG_NAME="brutefir"
PKG_VERSION="1.0o"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="Proprietary"
PKG_SITE="https://torger.se/anders/brutefir.html"
PKG_URL="https://torger.se/anders/files/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_MAINTAINER="chipfunk" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_HOST="flex"
PKG_DEPENDS_TARGET="alsa-lib fftw3 fftw3f"
PKG_SECTION="service/system"
PKG_SHORTDESC="FIR convolver"
PKG_LONGDESC="BruteFIR is a software convolution engine, a program for applying long FIR filters to multi-channel digital audio."
PKG_TOOLCHAIN="make" # or one of auto, meson, cmake, cmake-make, configure, make, ninja, autotools, manual

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="BruteFIR"
PKG_ADDON_TYPE="xbmc.service.library"
# PKG_ADDON_PROJECTS="[project, only set when not any]"
# PKG_ADDON_PROVIDES="executable"
# PKG_ADDON_REQUIRES="some.addon:0.0.0"

#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "

#pre_configure_target() {
#  do something, or drop it
#}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  cp ${PKG_INSTALL}/usr/bin/brutefir ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}

# see https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/readme.md for more
# take a look to other packages, for inspiration
