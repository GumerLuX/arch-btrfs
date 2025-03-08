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

write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Eliguiendo el escritorio de trabajo https://wiki.archlinux.org/title/Desktop_environment
KDE-Plasma o Hyprland"
read -p "Que escritorio deseas instalar (ej: plasma): " escritorio

case $escritorio in
    plasma)
        plasma
        ;;
    hyprland)
        hyprland
        ;;
    *)
        echo "Escritorio no reconocido. Por favor elige 'plasma' o 'hyprland'."
        exit 1
        ;;
esac

plasma(){
    write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
    print_info "Instalando escritorio KDE-Plasma https://wiki.archlinux.org/title/KDE#Plasma"
    sudo pacman --noconfirm -S plasma-pa plasma-nm plasma-systemmonitor kscreen khotkeys powerdevil kdeplasma-addons kde-gtk-config breeze-gtk alacritty dolphin kate mpv ark iwd konsole plasma-meta plasma-workspace smartmontools vim wget wiriless_tools plymouth gwenview
}

hyprland(){
    write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
    print_info "Instalando escritorio Hyprland https://wiki.archlinux.org/title/Hyprland"
    sudo pacman --noconfirm -S hyprland
}

sddm(){
    write_header "Configuracion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
    print_info "Instalando gestor de pantalla sddm https://wiki.archlinux.org/title/SDDM"
    pacman --noconfirm -S sddm
    # Personalizar SDDM (Opcional)
    yay -S sddm-sugar-candy-git
    sudo bash -c 'cat >> /etc/sddm.conf <<EOF
    [Theme]
    Current=sugar-candy
    EOF'

    # Habilitar SDDM
    sudo systemctl enable sddm
    sudo systemctl start sddm


