#!/bin/bash

sudo dnf update;
sudo dnf upgrade -y;
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org;
sudo dnf install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm -y;
sudo sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/elrepo.repo;
sudo dnf --enablerepo=elrepo-kernel install kernel-ml -y;
sudo grub2-mkconfig -o /boot/grub2/grub.cfg; sudo grub2-mkconfig -o /boot/efi/EFI/almalinux/grub.cfg;
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/elrepo.repo;
# проверить
sudo sed -i 's/\(GRUB_CMDLINE_LINUX=".*\)"/\1 amd_pstate=passive"/' /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg; sudo grub2-mkconfig -o /boot/efi/EFI/almalinux/grub.cfg


sudo reboot
sudo cpupower frequency-set -g performance