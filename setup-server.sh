#!/bin/bash

set -e
set -u

# Switch to a fast mirror
echo 'Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# Upgrade pacman
pacman -Sy pacman --noconfirm

# http://www.archlinux.org/news/filesystem-upgrade-manual-intervention-required/
pacman -S filesystem --force --noconfirm

# http://www.archlinux.org/news/initscripts-update-manual-intervention-required/
rm -f /etc/profile.d/locale.sh

# Upgrade system
pacman -Su --noconfirm

# Remove some unneeded packages
pacman -Rcs jfsutils lvm2 mdadm pcmciautils ppp reiserfsprogs wpa_supplicant xfsprogs

# Install some base packages
pacman -S --noconfirm base-devel jshon rsync linux grub sudo systemd systemd-arch-units python

# Clean up known-good configuration backup files
rm -f /etc/rc.conf.pacnew
rm -f /etc/pacman.d/mirrorlist.pacnew
rm -f /etc/locale.gen.pacnew

# Bootstrap packer
mkdir -p /usr/local/bin
curl https://raw.github.com/bruenig/packer/master/packer > /usr/local/bin/packer
chmod +x /usr/local/bin/packer
packer -Syu
packer -S --noconfirm packer

# Install puppet
packer -S --noconfirm puppet

# Download ps_mem.py
curl https://raw.github.com/pixelb/scripts/master/scripts/ps_mem.py > /usr/local/bin/ps_mem.py
chmod +x /usr/local/bin/ps_mem.py

# Apply configuration manifest
puppet apply /etc/puppet/manifests/site.pp
