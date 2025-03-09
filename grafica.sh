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

#Instalamos servidor grafico, XORG Y MESA
write_header "Configuración de la tarjeta gráfica"
print_info "Instalando servidor gráfico Xorg y Mesa..."
pacman -S xorg xorg-xinit mesa mesa-demos xorg-server xorg-utils xorg-server-utils --noconfirm

# Detectar la GPU
write_header "Configuración de la tarjeta gráfica"
print_info "Detectando la tarjeta gráfica..."
GPU=$(lspci | grep -Ei 'vga|3d|display')
echo "GPU encontrada: $GPU"

# Determinar el fabricante y asignar el paquete correcto
if echo "$GPU" | grep -qi "NVIDIA"; then
    DRIVER="nvidia nvidia-utils nvidia-settings"
    echo "Se detectó una GPU NVIDIA."
elif echo "$GPU" | grep -qi "AMD"; then
    DRIVER="vulkan-radeon xf86-video-amdgpu"
    echo "Se detectó una GPU AMD."
elif echo "$GPU" | grep -qi "Intel"; then
    DRIVER="intel-media-driver libva-intel-driver vulkan-intel --noconfirm"
    echo "Se detectó una GPU Intel."
elif echo "$GPU" | grep -qi "VMware"; then
    DRIVER="xf86-video-vmware virtualbox-guest-utils"
else
    echo "No se pudo detectar una GPU compatible. Saliendo..."
    exit 1
fi

# Confirmación antes de instalar
echo "Se instalarán los siguientes paquetes: $DRIVER"
read -p "¿Deseas continuar con la instalación? (s/n): " RESPUESTA

if [[ "$RESPUESTA" =~ ^[Ss]$ ]]; then
    sudo pacman -Syu --needed $DRIVER
        
    # Configurar VirtualBox Guest Utils si es necesario
    if [[ "$DRIVER" == "virtualbox-guest-utils" ]]; then
        echo "Habilitando y arrancando el servicio de VirtualBox Guest Additions..."
        sudo systemctl enable vboxservice
        sudo systemctl start vboxservice
        sudo usermod -aG vboxsf $USER
    fi

    echo "Instalación completada."
else
    echo "Instalación cancelada."
fi
