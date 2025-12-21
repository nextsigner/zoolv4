#!/bin/bash

cd ~/
mkdir -p ~/proc-swe-files
cd ~/proc-swe-files
git clone https://github.com/nextsigner/zool-swe

cd ./zool-swe/swe

# Directorio donde están los archivos (puedes cambiarlo a "." si estás dentro)
TARGET_DIR="."
TEMP_DIR="./temp_sweph_save"

echo "Iniciando limpieza de Swiss Ephemeris para rango 1400-2100..."

# 1. Crear carpeta temporal para salvar archivos necesarios
mkdir -p $TEMP_DIR

# 2. Lista de archivos a conservar:
# sepl_12 y sepl_18 -> Planetas (1200-2400)
# semo_12 y semo_18 -> Luna (1200-2400)
# seas_12 y seas_18 -> Asteroides principales (1200-2400)
# fixstars.cat -> Estrellas fijas
# seorbel.txt -> Necesario para órbitas y eclipses
# s136199.se1 -> Eris (opcional pero común en astrología moderna)

files_to_save=(
    "sepl_12.se1" "sepl_18.se1"
    "semo_12.se1" "semo_18.se1"
    "seas_12.se1" "seas_18.se1"
    "fixstars.cat"
    "seorbel.txt"
    "s136199.se1"
    "LICENSE.TXT"
    "README.TXT"
)

echo "Salvando archivos esenciales..."

for file in "${files_to_save[@]}"; do
    if [ -f "$TARGET_DIR/$file" ]; then
        mv "$TARGET_DIR/$file" "$TEMP_DIR/"
        echo "Guardado: $file"
    else
        echo "Advertencia: No se encontró $file"
    fi
done

# 3. Eliminar todos los archivos .se1 restantes en el directorio original
echo "Eliminando archivos no deseados..."
rm -f $TARGET_DIR/*.se1
rm -f $TARGET_DIR/*.cat
rm -f $TARGET_DIR/*.txt

# 4. Devolver los archivos guardados al directorio original
mv $TEMP_DIR/* $TARGET_DIR/
rmdir $TEMP_DIR

echo "--------------------------------------------------"
echo "Limpieza completada."
echo "Rango de fechas garantizado: 1200 d.C. - 2400 d.C."
echo "Tu instalador ahora es mucho más ligero."
