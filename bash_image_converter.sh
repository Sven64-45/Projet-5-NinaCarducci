#!/bin/bash

# Répertoire d'entrée (où se trouvent les images JPG)
input_directory="assets/images"

# Répertoire de sortie (où seront sauvegardées les images WebP)
output_directory="assets/images"

# Assurez-vous que l'outil cwebp est installé
if ! command -v cwebp &> /dev/null; then
    echo "L'outil cwebp n'est pas installé. Veuillez l'installer pour continuer."
    exit 1
fi

# Assurez-vous que le répertoire de sortie existe, sinon créez-le
mkdir -p "$output_directory"

# Parcours des fichiers et sous-dossiers dans le répertoire d'entrée
find "$input_directory" -type f -name "*.jpg" | while read -r jpg_file; do
    # Extraire le chemin relatif du fichier
    relative_path="${jpg_file#$input_directory}"

    # Extraire le nom de fichier sans l'extension
    base_name=$(basename "$jpg_file" .jpg)

    # Créer le répertoire de sortie pour le fichier
    mkdir -p "$output_directory${relative_path%/*}"

    # Convertir l'image JPG en WebP et la sauvegarder dans le répertoire de sortie
    cwebp -q 80 "$jpg_file" -o "$output_directory${relative_path%.*}.webp"

    echo "Conversion de $jpg_file en $output_directory${relative_path%.*}.webp"
done

echo "Conversion terminée."

