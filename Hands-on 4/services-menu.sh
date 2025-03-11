#!/bin/bash

while true; do
    # Mostrar el menú
    echo "SERVICES MENU"
    echo "1. Listar el contenido de un directorio"
    echo "2. Crear un archivo de texto"
    echo "3. Comparar dos archivos de texto"
    echo "4. Comando awk"
    echo "5. Comando grep"
    echo "6. Salir"
    read -p "Seleccione una opción: " option

    case $option in
        1)
            read -p "Ingrese la ruta absoluta del directorio: " dir
            if [ -d "$dir" ]; then
                ls -la "$dir"
            else
                echo "El directorio no existe."
            fi
            ;;
        2)
            read -p "Ingrese el nombre del archivo a crear: " filename
            read -p "Ingrese el texto a almacenar: " text
            echo "$text" > "$filename"
            echo "Archivo '$filename' creado con éxito."
            ;;
        3)
            read -p "Ingrese el primer archivo: " file1
            read -p "Ingrese el segundo archivo: " file2
            if [ -f "$file1" ] && [ -f "$file2" ]; then
                diff "$file1" "$file2"
            else
                echo "Uno o ambos archivos no existen."
            fi
            ;;
        4)
            echo "Comando awk para filtar por edad"
            read -p "Ingrese la edad: " age
            echo "Imprimendo mayores de $age"
            awk -v edad="$age" '$2 > edad' ejemplo.txt
            ;;
        5)
            echo "Comando grep para buscar por nombre:"
            read -p "Ingrese nombre: " name
            grep "$name" ejemplo.txt
            ;;
        6)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Inténtelo de nuevo."
            ;;
    esac
    echo ""
done
