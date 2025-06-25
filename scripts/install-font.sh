#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo "Uso: $0 <fonte.zip>"
    exit
fi

FONT_FILE=$1

if ! (file "$FONT_FILE" | grep -q -i "zip archive") ; then
    echo "$FONT_FILE não é um arquivo Zip"
    exit
fi

# Instala no diretório local de fontes
FONT_NAME=$(basename "$FONT_FILE" .zip)
FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"

echo "Descompactando fonte"
mkdir -p "$FONT_DIR"
unzip -n "$FONT_FILE" -d "$FONT_DIR"
echo

# Atualiza cache e verifica
echo "Gerando cache"
fc-cache "$FONT_DIR"
echo

echo "Verificando fonte"
fc-list | grep "$FONT_NAME"
