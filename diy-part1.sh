#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# (Opsional) Ganti atau tambah feed source jika diperlukan
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# Tambahkan patch untuk mengaktifkan USB di Mi Router 4C
patch -d openwrt -p1 << 'EOF'
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
