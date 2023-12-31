# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

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
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REQUIRES="service.system.fftw3:11.0.0.100 service.system.fftw3f:11.0.0.100"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/bin
  cp ${PKG_INSTALL}/usr/bin/brutefir ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/bin

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/lib
  cp -r ${PKG_INSTALL}/usr/lib/brutefir ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/lib

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/share/brutefir
  cp -r ${PKG_DIR}/brutefir_defaults ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/share/brutefir
  cp -r ${PKG_DIR}/brutefir_config.example ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/share/brutefir
}
