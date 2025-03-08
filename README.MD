
### Caracteristicas

Creación de un script de Archlinux con sistema UEFI y archivos btrfs, para la creación de instantáneas de recuperación del sistema.

### Variables
Este script te pide unas variables de tu disco, partición /boot/efi, la de root/, tu usuario y el hostname de tu pc.

### Utilización
El primer script arch_install_btrfs.sh hace una instalación simple del sistema Arch desde chroot y reiniciamos.

El 2 script 2-install_config.sh instala la configuración básica para el sistema /root y el usuario /home. 
Opcion de instalar  el escritorio KDE-Plasma, hyprland o ambos. Te busca la grafica y la instala, tanto si es una Maquina Virtual.

### Detalles
Antes de instalar el escritorio instalar los scripts 3,4,5, y 6.  

### Scripts informacion
Pudiendo instalar otros scripts para poder tener el sistema deseado.

arch_install_btrfs.sh   >> Instalación Base
2-install_config.sh		>> Configuración post root/usuario
3-yay.sh			    >> Repositorio de Archlinux mejorado por usuarios
4-zram.sh			    >> Bloque de memoria RAM creada desde el /tmp
5-timeshift.sh			>> Crear instantáneas del sistema de archivo
6-preload.sh			>> Carga la utilización de la memoria desde el SDD 
7-kvm.sh			    >> Si vas ha utilizar una KVM/QEMU/VIRT MANAGER
snapshot.sh			    >> Para crear instantáneas del sistema
escritorio.sh			>> Se instala con “2-install_config.sh”
grafica.sh	 	    	>> Se instala con “2-install_config.sh”

### Sacado de la web por otros usuarios.
Mi primera guia par instalar Arch.
https://gist.github.com/MasterGeekMX/6e2d4e47d9852c04f162bf672066daa5#introducci%C3%B3nhttps://www.youtube.com/@Ruben-Linux

Configurar KDE plasma, simple y util el mejor. 
https://www.youtube.com/@SoplosLinux
https://www.youtube.com/watch?v=Cco4VMUcZuQ

My Linux For Work por Stephan Raabe.
Donde he sacado la configuracion (copiar y pegar) de sus scripts
https://www.youtube.com/@mylinuxforwork
Instalacion de scripts
https://www.youtube.com/watch?v=bKE7Af7nqGw&list=PLZhEtW7iLbnB40354EM5X1mF5QXcge91Q&index=4
Paguina de gitlab
https://gitlab.com/stephan-raabe/archinstall

Gracias a todos y un abrazo a la comunidadde ArchLinux.