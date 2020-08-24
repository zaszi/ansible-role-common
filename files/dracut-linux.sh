#!/bin/bash

args=('-H' '--no-hostonly-cmdline')

while read -r line; do
    if [[ $line = usr/lib/modules/+([^/])/pkgbase ]]; then
        mapfile -O ${#pkgbase[@]} -t pkgbase <"/$line"
        kver=${line#"usr/lib/modules/"}
        kver=${kver%"/pkgbase"}
    fi
done

cp /usr/lib/modules/"${kver[*]}"/vmlinuz /boot/vmlinuz-linux

dracut "${args[*]}" -f /boot/initramfs-"${pkgbase[*]}".img --kver "${kver[*]}"
