#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)

# Ubah IP default router (opsional)
# sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate

# Ubah hostname (opsional)
sed -i 's/OpenWrt/OpenWrt-4C/g' package/base-files/files/bin/config_generate

# Nonaktifkan initramfs agar hanya squashfs yang dibangun
sed -i '/CONFIG_TARGET_ROOTFS_INITRAMFS/d' .config
echo 'CONFIG_TARGET_ROOTFS_INITRAMFS=n' >> .config
