#!/bin/bash

# Verificar si se proporcionó un argumento (nombre del archivo CSV)
if [ $# -eq 0 ]
then
    echo "Debe proporcionar el nombre del archivo CSV como argumento."
    exit 1
fi

# Obtener el nombre del archivo sin la extensión
archivo_original="${1%.*}"

# Verificar si el archivo existe
if [ ! -f "$1" ]
then
    echo "El archivo $1 no existe."
    exit 1
fi

# Solicitar el número de campos al usuario
read -p "Ingrese el número de campos por fila: " num_campos

# Generar el patrón para el comando sed
patron=""
for ((i=1; i<=num_campos; i++))
do
    if [ $i -eq 1 ]
    then
        patron="[^,]*"
    else
        patron="$patron,[^,]*"
    fi
done

# Generar el nombre del archivo de salida
archivo_salida="${archivo_original}_limpio.csv"

# Ejecutar el comando sed
sed "s/^\($patron\).*$/\1/" "$1" > "$archivo_salida"

echo "Proceso completado. Se ha creado el archivo '$archivo_salida'."

