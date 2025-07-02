#!/bin/bash
#
# diy-part2.sh – dijalankan dari dalam folder 'openwrt'
DTS_FILE="target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4c.dts"

if [ -f "$DTS_FILE" ]; then
  sed -i 's/status = "disabled"/status = "okay"/g' "$DTS_FILE"
  echo "✅ USB EHCI/OHCI diaktifkan di $DTS_FILE"
else
  echo "❌ File DTS tidak ditemukan: $DTS_FILE"
  exit 1
fi
