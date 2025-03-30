#!/bin/bash

# Solicitar datos al usuario
read -p "Nombre de la máquina virtual: " NOMBRE_VM
read -p "Tipo de sistema operativo: " TIPO_SO
read -p "Número de CPUs: " CPUS
read -p "Tamaño de RAM en GB: " RAM_GB
read -p "Tamaño de VRAM en MB: " VRAM_MB
read -p "Tamaño de disco duro en GB: " DISK_GB
read -p "Nombre del controlador SATA: " CONTROLADOR_SATA
read -p "Nombre del controlador IDE: " CONTROLADOR_IDE

# Crear máquina virtual
VBoxManage createvm --name "$NOMBRE_VM" --ostype "$TIPO_SO" --register

# CPUs y RAM
VBoxManage modifyvm "$NOMBRE_VM" --cpus "$CPUS" --memory $(($RAM_GB * 1024)) --vram "$VRAM_MB"

# Disco duro
DISK_PATH="$NOMBRE_VM.vdi"
VBoxManage createmedium disk --filename "$DISK_PATH" --size $(($DISK_GB * 1024)) --format VDI

# Controlador SATA
VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR_SATA" --add sata --controller IntelAhci
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$CONTROLADOR_SATA" --port 0 --device 0 --type hdd --medium "$DISK_PATH"

# Controlador IDE para CD/DVD
VBoxManage storagectl "$NOMBRE_VM" --name "$CONTROLADOR_IDE" --add ide

# Mostrar la configuración final
VBoxManage showvminfo "$NOMBRE_VM"

