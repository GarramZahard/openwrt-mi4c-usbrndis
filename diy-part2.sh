#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)

# Ubah IP default router (opsional)
# sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate

# Ubah hostname (opsional)
sed -i 's/OpenWrt/OpenWrt-4C/g' package/base-files/files/bin/config_generate

# Aktifkan EHCI & OHCI untuk USB agar RNDIS bisa dipakai
patch -p1 <<'EOF'
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
