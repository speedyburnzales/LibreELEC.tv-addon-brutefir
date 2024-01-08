# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="brutefir"
PKG_VERSION="1.0o"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="Proprietary"
PKG_SITE="https://torger.se/anders/brutefir.html"
PKG_URL="http://github.com/chipfunk/${PKG_NAME}/archive/refs/tags/${PKG_VERSION}-pulse.tar.gz"
PKG_SHA256="e6c9af0e6fd504cb16f87da51bd75b2ecb2ef99aae50aea3c368b85265ba52f1"
PKG_MAINTAINER="chipfunk" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_HOST="flex"
PKG_DEPENDS_TARGET="pulseaudio alsa-lib fftw3 fftw3f"
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
  cp ${PKG_BUILD}/brutefir ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/bin

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/lib/brutefir
  cp -r ${PKG_BUILD}/*.bfio ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/lib/brutefir
  cp -r ${PKG_BUILD}/*.bflogic ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/lib/brutefir

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/share/brutefir
  cp -r ${PKG_DIR}/brutefir_defaults ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/share/brutefir
  cp -r ${PKG_DIR}/brutefir_config.example ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/share/brutefir
  cp -r ${PKG_DIR}/pulseaudio.sh ${ADDON_BUILD}/${PKG_ADDON_ID}/usr/share/brutefir
}
