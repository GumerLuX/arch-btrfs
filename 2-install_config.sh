#!/bin/bash
#Version:0.1 
#Scrip de instalacion d ArchLinux UEFI btrfs 2-install_config.sh

#estilos
if [[ -f $(pwd)/estilos ]]; then
    source estilos
else
    echo "missing file: estilos"
    exit 1
fi

# Estableciendo variables configuracion
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Este script se ha de realizar con el usuario root"
print_info "Estableciendo variables de configuracion"
read -p "Tu teclado es ej:(es):" keymap
read -p "Tu locale es ej:(es_ES):" LOCALE
read -p "Tu zonainfo es: ej:(Europe/Madrid):" zonainfo
read -p "Tu hostname es: ej:(archlinux):" hostname
read -p "Tu nombre de usuario es: ej:(usuario):" username

# Establecer la hora del sistema
writw_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Configurando la zona horaria"
ln -sf /usr/share/zoneinfo/$zonainfo /etc/localtime
hwclock --systohc

# Actualizando reflector Sincronizar espejos
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Actualizando reflector"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
echo "Start reflector..."
reflector -c "Germany,France,Spain" -p https -a 5 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

# Instalacion de paquetes
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Instalando paquetes"
pacman --noconfirm -S xdg-desktop-portal-wlr network-manager-applet dialog wpa_supplicant mtools dosfstools linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils bash-completion openssh rsync acpi acpi_call dnsmasq openbsd-netcat ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font exa bat htop ranger zip unzip neofetch duf xorg xorg-xinit xclip xf86-video-nouveau xf86-video-qxl brightnessctl pacman-contrib inxi

# Detectando tarjeta grafdica
./grafica.sh

# Estableciendo idioma
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Estableciendo idioma utf8 $keymap"
sed -i "/"$LOCALE".UTF/s/^#//g" /etc/locale.gen
echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=es_ES.UTF-8" >> /etc/locale.conf

# Estableciendo teclado
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Estableciendo teclado $keymap"
echo "FONT=ter-v18b" >> /etc/vconsole.conf
echo "KEYMAP=$keymap" >> /etc/vconsole.conf

# Estableciendo hostname y localhost
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Estableciendo hostname $hostname"
echo "$hostname" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts
cat /etc/hostname

# Establecer contraseña de root
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Estableciendo contraseña de root"
echo "Establecer contraseña de root"
passwd root

#Creando usuario
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Creando usuario $username"
echo "Add user $username"
useradd -m -G wheel $username
echo "Establecer contraseña de $username"
passwd $username

# Dar color a nano
write_header "4.B - PONEMOS COLOR A NANO - https://gumerlux.github.io/Blog.GumerLuX/"
print_info "  Configuramos 'nano' tanto para nuestro usuario como para root"
pause_function
sed -i '/*.nanorc/s/^#//g' /etc/nanorc
sed -i '/set linenumbers/s/^#//g' /etc/nanorc

# Configuracion de Pacman, color y ponemos el comococos en la barra
write_header "5.A - CONFIGURACION DE PACMAN - https://gumerlux.github.io/Blog.GumerLuX/"
print_info " Tenemos que modificar, el archivo ${Gray}/etc/pacman.conf${fin}"
print_info " Descomentamos el hastag de la linea #Color del archivo ${Gray}/etc/pacman.conf{fin}  
  Añadimos al final del grupo color ${Gray}ILoveCandy${fin}, las letras 'ILC' sonmayusculas.
  Desmarcamos las casillas de:
      [multilib]
      include /ete/pacman.d/mirrorlist"
pause_function
cp -vf /etc/pacman.conf /etc/pacman.conf.olg
sed -i "/Color/s/^#//g" /etc/pacman.conf
sed -i "37i ILoveCandy" /etc/pacman.conf
sed -i 's/ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
echo  "[multilib]" >> /etc/pacman.conf
echo  "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
print_info "Comprobando el archivo pacman.conf"
nano /etc/pacman.conf
pacman -Sy

# Habilitando servicios
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Habilitando servicios"
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid
systemctl --user enable pipewire pipewire-pulse wireplumber

# Grub instalacion
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs" 
print_info "Instalando grub"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg
 
# Agregemos btrfs y setfont a mkinitcpio
# Before: BINARIES=()
# After:  BINARIES=(btrfs setfont)
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Agregando btrfs y setfont a mkinitcpio.conf"
sed -i 's/BINARIES=()/BINARIES=(btrfs setfont)/g' /etc/mkinitcpio.conf
echo "HOOKS=(base udev plymouth añadir"
nano /etc/mkinitcpio.conf
mkinitcpio -p linux

# Agregamos usuario a el grupo 'wheel'
write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Agregando usuario a el grupo 'wheel'"
echo Defaults  env_reset,pwfeedback >> /etc/sudoers
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^#//' /etc/sudoers
usermod -aG wheel $username

# Copiamos el scripts de instalacion al directorio home 
cp -r $(pwd) /home/$username
chown -R $username:users /home/$username

sed -i 's/^#%wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
print_info "Configuracion finalizada"
echo "     _                   "
echo "  __| | ___  _ __   ___  "
echo " / _' |/ _ \| '_ \ / _ \ "
echo "| (_| | (_) | | | |  __/ "
echo " \__,_|\___/|_| |_|\___| "
echo "                         "
echo ""
echo "Instalacion adicional de scripts en su directorio home:"
echo "- yay AUR helper: 3-yay.sh"
echo "- zram swap: 4-zram.sh"
echo "- Herramienta de instantanea timeshift: 5-timeshift.sh"
echo "- preload aplicacion de cache: 6-preload.sh"
echo "- Aplicacion de instantanea: snapshot.sh"
echo ""
echo "Escriva: exit & shutdown (shutdown -h now) para apagar la computadora,retire el medio de instalacion y empiece de nuevo."