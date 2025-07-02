#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)

# Ubah IP default router (opsional)
# sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate

# Ubah hostname
sed -i 's/OpenWrt/OpenWrt-4C/g' package/base-files/files/bin/config_generate

# Nonaktifkan initramfs agar hanya squashfs yang dibangun
sed -i '/CONFIG_TARGET_ROOTFS_INITRAMFS/d' .config
echo 'CONFIG_TARGET_ROOTFS_INITRAMFS=n' >> .config
sed -i '/CONFIG_TARGET_IMAGES_INITRAMFS/d' .config
echo 'CONFIG_TARGET_IMAGES_INITRAMFS=n' >> .config

# Set password default untuk root jadi "Yudhistira1"
PASSWD_HASH=$(openssl passwd -1 "Yudhistira1")

# Pastikan direktori shadow ada
mkdir -p package/base-files/files/etc

# Jika file shadow tidak ada, buat dengan isi default (hanya root)
if [ ! -f package/base-files/files/etc/shadow ]; then
  echo "root::0:0:99999:7:::" > package/base-files/files/etc/shadow
fi

# Ganti password root
sed -i "s|^root:[^:]*:|root:${PASSWD_HASH}:|" package/base-files/files/etc/shadow
