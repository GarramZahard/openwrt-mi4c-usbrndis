#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# --- Tambahkan patch DTS agar port USB aktif di Xiaomi Mi Router 4C ---
patch -p1 << 'EOF'
--- a/target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4c.dts
+++ b/target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4c.dts
@@
 &ehci {
-       status = "disabled";
+       status = "okay";
 };

 &ohci {
-       status = "disabled";
+       status = "okay";
 };
EOF
