#!/bin/bash
#
# diy-part2.sh – dijalankan dari dalam folder 'openwrt'

echo "📂 Working directory: $(pwd)"
echo "📂 GITHUB_WORKSPACE: $GITHUB_WORKSPACE"
echo "📄 Listing patches folder:"
ls -l "$GITHUB_WORKSPACE/patches"

#######################################################################
# 1) PATCH DTS: aktifkan USB EHCI/OHCI untuk Xiaomi Mi Router 4C
#######################################################################
patch -p1 < "$GITHUB_WORKSPACE/patches/0001-enable-usb.patch" || {
  echo "❌  Patch USB gagal diterapkan"
  exit 1
}

#######################################################################
# 2) Ubah hostname (opsional)
#######################################################################
sed -i 's/OpenWrt/OpenWrt-4C/g' package/base-files/files/bin/config_generate

#######################################################################
# 3) Nonaktifkan pembuatan initramfs – hanya squashfs
#######################################################################
for opt in CONFIG_TARGET_ROOTFS_INITRAMFS CONFIG_TARGET_IMAGES_INITRAMFS; do
  sed -i "/${opt}/d" .config
  echo "${opt}=n" >> .config
done
