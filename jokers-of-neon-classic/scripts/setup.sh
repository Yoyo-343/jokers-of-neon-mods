#!/bin/bash

# Get project name from Scarb.toml
project_name=$(grep '^name = ' Scarb.toml | cut -d'"' -f2)

update_writers() {
    # Extraer los special IDs del archivo specials.cairo
    special_ids=$(grep -o 'const [A-Z_]*_ID: u32 = [0-9]*;' src/specials/specials.cairo | cut -d' ' -f2 | tr -d ':')
    
    # Crear la lista de writers
    writers="\"$project_name-registrator_system\",\n\"$project_name-configurator_system\",\n"
    for special in $special_ids; do
        # Eliminar el sufijo _ID y convertir a minúsculas
        system_name=$(echo $special | sed 's/_ID$//' | tr '[:upper:]' '[:lower:]')
        writers="${writers}    \"$project_name-$system_name\",\n"
    done
    
    # Eliminar la última coma y salto de línea
    writers=${writers%,\\n}
    
    # Actualizar el archivo dojo_dev.toml
    # Primero respaldamos el archivo original
    cp dojo_dev.toml dojo_dev.toml.bak
    
    # Actualizar la sección de writers
    awk -v writers="$writers" '
    BEGIN { printing = 1 }
    /^\[writers\]/ {
        print $0
        print "\"$project_name\" = ["
        printf writers
        print "\n]"
        printing = 0
        next
    }
    /^\[/ { printing = 1 }
    printing && !/^"$project_name"/ { print }
    ' dojo_dev.toml.bak > dojo_dev.toml
    
    # Remove the backup file
    rm dojo_dev.toml.bak
}

update_writers

set -e
if [ -d "target" ]; then
    rm -rf "target"
fi

if [ -d "manifests" ]; then
    rm -rf "manifests"
fi

echo "sozo build && sozo inspect && sozo migrate"
sozo build && sozo inspect && sozo migrate

echo -e "\n✅ Setup finish!"
