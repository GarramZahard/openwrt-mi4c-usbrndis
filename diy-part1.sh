#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# (Opsional) Ganti atau tambah feed source jika diperlukan
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# Masuk ke direktori sumber OpenWrt
cd openwrt || exit 1

# Patch DTS agar USB aktif untuk Xiaomi Mi Router 4C
patch -p1 < "$GITHUB_WORKSPACE/patches/0001-enable-usb.patch"
