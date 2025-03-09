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
    sudo pacman --noconfirm --needed -S plasma-meta plasma-pa plasma-nm plasma-systemmonitor kscreen powerdevil kdeplasma-addons kde-gtk-config breeze-gtk alacritty dolphin kate mpv ark iwd konsole plasma-workspace smartmontools vim wget wireless_tools plymouth gwenview nano
}

# Función para instalar Hyprland
hyprland(){
    write_header "Configuración de ArchLinux UEFI Btrfs https://wiki.archlinux.org/title/Btrfs"
    print_info "Instalando escritorio Hyprland https://wiki.archlinux.org/title/Hyprland"
    sudo pacman --noconfirm --needed -S hyprland waybar hyprpaper xdg-desktop-portal-hyprland wayland wlroots xorg-xwayland polkit-kde-agent mako grim slurp wofi kitty dolphin firefox neofetch dolphin dunst qt5-wayland qt6-wayland nano
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
  
echo -e "   1.Escritorio${Yellow} Kde Plasma ${fin}"
echo -e "   2.Escritorio${Yellow} Hyprland ${fin}"
  echo
  echo    "   b) Atras"
  echo
  read -p "Introduzca opcion:" op
    if [ "$op" ]; then
        case $op in
            1) plasma ;;
            2) hyprland ;;
            b) exit 1 ;;
            *) echo "Opcion no valida" ;;
        esac
    fi

# Instalando el gestor de pantalla SDDM
sddm
