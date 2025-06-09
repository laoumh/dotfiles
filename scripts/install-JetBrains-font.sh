#!/usr/bin/env bash

FONT_NAME="JetBrainsMono"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip"
FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"
# `mktemp` já cria o diretório
WORK_DIR=$(mktemp -d -t fonts-XXXXXX)

# Baixa a fonte
cd "$WORK_DIR"
curl -fLO "$FONT_URL"

# Colaca no diretório
mkdir -p "$FONT_DIR"
unzip JetBrainsMono.zip -d "$FONT_DIR"

# Atualiza cache e verifica
fc-cache -f -v
echo "Verificando:"
fc-list | grep "$FONT_NAME"
