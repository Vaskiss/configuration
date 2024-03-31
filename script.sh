#!/bin/bash

dnf update
dnf upgrade -y
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
dnf install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm -y
sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/elrepo.repo
dnf --enablerepo=elrepo-kernel install kernel-ml -y
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/almalinux/grub.cfg
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/elrepo.repo
sed -i 's/\(GRUB_CMDLINE_LINUX=".*\)"/\1 amd_pstate=passive"/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-mkconfig -o /boot/efi/EFI/almalinux/grub.cfg

reboot
cpupower frequency-set -g performance
