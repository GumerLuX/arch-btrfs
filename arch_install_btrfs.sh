#!/bin/bash
#Version:0.1 
#Scrip de instalacion d ArchLinux UEFI btrfs

#estilos
if [[ -f $(pwd)/estilos ]]; then
	source estilos
else
	echo "missing file: estilos"
	exit 1
fi

#Fuente tty
setfont ter-122n

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Sincronuzando la hora de la maquina"
timedatectl set-ntp true

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Creando particiones"
lsblk
read -p "Introduce el nombre del disco a instalar (ej: nvme1n1):" disco
cfdisk /dev/$disco

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "introduce las particiones creadas"
lsblk /dev/$disco
read -p "Introduce el nombre de la particion EFI (ej: nvme1n1p1):" efi
read -p "Introduce el nombre de la particion ROOT (ej: nvme1n1p2):" root

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Formateando particiones"
mkfs.fat -F 32 /dev/$efi
mkfs.btrfs -f /dev/$root  

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Montando particiones"
mount /dev/$sda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@log
umount /mnt

mount -o compress=zstd:1,noatime,subvol=@ /dev/$sda2 /mnt
mkdir -p /mnt/{boot/efi,home,.snapshots,var/{cache,log}}
mount -o compress=zstd:1,noatime,subvol=@cache /dev/$sda2 /mnt/var/cache
mount -o compress=zstd:1,noatime,subvol=@home /dev/$sda2 /mnt/home
mount -o compress=zstd:1,noatime,subvol=@log /dev/$sda2 /mnt/var/log
mount -o compress=zstd:1,noatime,subvol=@snapshots /dev/$sda2 /mnt/.snapshots

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Instalando paquetes basicos"
pacstrap -K /mnt base base-devel linux linux-firmware git btrfs-progs grub efibootmgr grub-btrfs inotify-tools timeshift vim networkmanager pipewire pipewire-alsa pipewire-pulse pipewire-jack reflector zsh zsh-completions zsh-autosuggestions openssh man sudo

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Generando el fstab"
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab 

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Configurando chroot"
cp -r /root/arch-btrfs /mnt/root

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Chroot"
arch-chroot /mnt /root/arch-btrfs/2-install_config.sh

