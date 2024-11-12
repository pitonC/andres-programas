#!/bin/bash

# Recorrer archivos de 11Andres.s a 20Andres.s
for i in {11..20}; do
    archivo="${i}Andres.s"
    ejecutable="${i}Andres"
    
    # Verificar si el archivo existe antes de compilar
    if [[ -f "$archivo" ]]; then
        echo "Compilando $archivo..."
        arm-linux-gnueabi-gcc -nostdlib -o "$ejecutable" "$archivo"
        
        # Verificar si la compilación fue exitosa
        if [[ $? -eq 0 ]]; then
            echo "Compilación de $archivo completada con éxito."
        else
            echo "Error al compilar $archivo."
        fi
    else
        echo "Archivo $archivo no encontrado."
    fi
done
