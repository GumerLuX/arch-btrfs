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

write_header "Instalacion de ArchLinux UEFI btrfs https://wiki.archlinux.org/title/Btrfs"
print_info "instalando utilidades basicas"

while true; do
  write_header "MENU PRINCIPAL - https://gumerlux.github.io/Blog.GumerLuX/"
  print_info "  Elige una opcion para empezar la configuracion"
  echo " 1) "Instalacion de AUR yay" "
  echo " 2) "Instalacion de Zram" "
  echo " 3) "Instalacion de timeshift" "
  echo " 4) "Instalacion de Preload" "
  echo " 5) "Instalacion de Escritorio" "
  echo ""
  echo " d) Salir"
  echo ""
  read_input_options
  for OPT in "${OPTIONS[@]}"; do
    case "$OPT" in
    1)
      ./yay.sh
      ;;
    2)
      ./szram.sh
      ;;
    3)
      ./timeshift.sh
      ;;
    4)
      ./preload.sh
      ;;
    5)
      ./escritorio.sh
      ;;    
    "d")
			write_header "GRACIAS por usar la configuracion https://gumerlux.github.io/Blog.GumerLuX/"
			sleep 1
      exit 1
      ;;
    *)
      invalid_option
      ;;
    esac
  done
done