#!/usr/bin/env bash

set -e

# Baixa a fonte
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
WORK_DIR=$(mktemp -d -t fonts-XXXXXX)
curl -fL --output-dir "$WORK_DIR" --remote-name "$FONT_URL"
FONT_FILE=$(find "$WORK_DIR" -type f)
printf "Fonte baixada em \'%s\'\n" "$FONT_FILE"

# Instala a fonte
printf "Iniciando instalação\n\n"
./install-font.sh "$FONT_FILE"
