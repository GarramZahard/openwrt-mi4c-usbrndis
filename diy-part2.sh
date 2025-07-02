#!/bin/bash
#
# Custom diy‑part2.sh  – dijalankan *setelah* feeds di‑update dan di‑install
#

#######################################################################
# 1) PATCH DTS: aktifkan USB EHCI/OHCI untuk Xiaomi Mi Router 4C
#######################################################################
# Folder kerja saat ini sudah "openwrt" (lihat workflow.yml).
# File patch berada satu level di atas, di folder "patches".
patch -p1 < "$GITHUB_WORKSPACE/patches/0001-enable-usb.patch" || {
  echo "❌  Patch USB gagal diterapkan"
  exit 1
}
#######################################################################
# 2) Ubah hostname (opsional)
#######################################################################
sed -i 's/OpenWrt/OpenWrt-4C/g' package/base-files/files/bin/config_generate

#######################################################################
# 3) Non‑aktifkan pembuatan initramfs – hanya squashfs yang dibangun
#######################################################################
for opt in CONFIG_TARGET_ROOTFS_INITRAMFS CONFIG_TARGET_IMAGES_INITRAMFS; do
  sed -i "/${opt}/d" .config
  echo "${opt}=n" >> .config
done

#######################################################################
# 4) Set password default root  →  Yudhistira1
#######################################################################
PASSWD_HASH="$(openssl passwd -1 'Yudhistira1')"

SHADOW_FILE=package/base-files/files/etc/shadow
mkdir -p "$(dirname "$SHADOW_FILE")"
# Jika shadow belum ada, buat entri root kosong dulu
[ -f "$SHADOW_FILE" ] || echo "root::0:0:99999:7:::" > "$SHADOW_FILE"
# Ganti hash password root
sed -i "s|^root:[^:]*:|root:${PASSWD_HASH}:|" "$SHADOW_FILE"

echo "✅ diy‑part2.sh selesai—patch USB OK, hostname & password diset, initramfs dimatikan"
