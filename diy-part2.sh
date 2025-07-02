#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)

# Ubah hostname router (opsional)
sed -i 's/OpenWrt/OpenWrt-4C/g' package/base-files/files/bin/config_generate

# Nonaktifkan build initramfs (agar hanya squashfs)
sed -i '/CONFIG_TARGET_ROOTFS_INITRAMFS/d' .config
sed -i '/CONFIG_TARGET_IMAGES_INITRAMFS/d' .config
echo 'CONFIG_TARGET_ROOTFS_INITRAMFS=n' >> .config
echo 'CONFIG_TARGET_IMAGES_INITRAMFS=n' >> .config

# Set password root default ke "Yudhistira1"
PASSWD_HASH=$(openssl passwd -1 "Yudhistira1")

# Siapkan file shadow jika belum ada
SHADOW_PATH="package/base-files/files/etc/shadow"
mkdir -p "$(dirname "$SHADOW_PATH")"
if [ ! -f "$SHADOW_PATH" ]; then
  echo "root::0:0:99999:7:::" > "$SHADOW_PATH"
fi

# Ganti password root di file shadow
sed -i "s|^root:[^:]*:|root:${PASSWD_HASH}:|" "$SHADOW_PATH"
