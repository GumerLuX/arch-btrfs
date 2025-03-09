#!/bin/bash
# Version: 0.1 
# Script de instalación de ArchLinux UEFI Btrfs

# Estilos
if [[ -f $(pwd)/estilos ]]; then
    source estilos
else
    echo "Missing file: estilos"
    exit 1
fi

# Función para instalar KDE Plasma
plasma(){
    write_header "Configuración de ArchLinux UEFI Btrfs https://wiki.archlinux.org/title/Btrfs"
    print_info "Instalando escritorio KDE-Plasma https://wiki.archlinux.org/title/KDE#Plasma"
    sudo pacman --noconfirm --needed -S plasma-pa plasma-nm plasma-systemmonitor kscreen powerdevil kdeplasma-addons kde-gtk-config breeze-gtk alacritty dolphin kate mpv ark iwd konsole plasma-meta plasma-workspace smartmontools vim wget wireless_tools plymouth gwenview
}

# Función para instalar Hyprland
hyprland(){
    write_header "Configuración de ArchLinux UEFI Btrfs https://wiki.archlinux.org/title/Btrfs"
    print_info "Instalando escritorio Hyprland https://wiki.archlinux.org/title/Hyprland"
    sudo pacman --noconfirm --needed -S hyprland waybar hyprpaper xdg-desktop-portal-hyprland wayland wlroots xorg-xwayland polkit-kde-agent mako grim slurp wofi kitty dolphin firefox neofetch 
}

# Función para instalar SDDM
sddm(){
    write_header "Configuración de ArchLinux UEFI Btrfs https://wiki.archlinux.org/title/Btrfs"
    print_info "Instalando gestor de pantalla SDDM https://wiki.archlinux.org/title/SDDM"
    sudo pacman --noconfirm -S sddm
    # Personalizar SDDM (Opcional)
    yay --noconfirm -S sddm-sugar-candy-git
    sudo bash -c 'cat > /etc/sddm.conf <<EOF
[Theme]
Current=sugar-candy
EOF'
    print_info "Escritorio instalado correctamente. Reinicia el sistema para aplicar los cambios."
    # Habilitar SDDM
    sudo systemctl enable sddm
    sudo systemctl start sddm
}

# Mensaje y elección del escritorio
write_header "Configuración de ArchLinux UEFI Btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "Eligiendo el escritorio de trabajo https://wiki.archlinux.org/title/Desktop_environment
KDE-Plasma o Hyprland"
read -p "¿Qué escritorio deseas instalar? (ej: plasma): " escritorio

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

# Instalando el gestor de pantalla SDDM
sddm

