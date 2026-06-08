#!/usr/bin/env bash
# Download and install a Nerd Font from a release URL.
# Browse available fonts at: https://github.com/ryanoasis/nerd-fonts/releases/
#
# Usage: ./install-font.sh <URL>
# Example: ./install-font.sh https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Uso: $0 <URL>"
    echo
    echo "Baixa e instala uma Nerd Font a partir de uma URL de release."
    echo "Veja as fontes disponíveis em:"
    echo "  https://github.com/ryanoasis/nerd-fonts/releases/"
    echo
    echo "Exemplo:"
    echo "  $0 https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz"
    exit 1
fi

URL=$1
FILENAME=$(basename "$URL")

# Detect archive type and derive font name
case "$FILENAME" in
    *.tar.xz) FONT_NAME="${FILENAME%.tar.xz}" ;;
    *.zip)    FONT_NAME="${FILENAME%.zip}" ;;
    *)        echo "Formato não suportado: $FILENAME (esperado .tar.xz ou .zip)"; exit 1 ;;
esac

FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo ":: Baixando $FILENAME..."
curl -fL -o "$TMPDIR/$FILENAME" "$URL"

# Remove old version
if [[ -d "$FONT_DIR" ]]; then
    echo ":: Removendo versão anterior em $FONT_DIR"
    rm -rf "$FONT_DIR"
fi

echo ":: Instalando em $FONT_DIR"
mkdir -p "$FONT_DIR"
case "$FILENAME" in
    *.tar.xz) tar xf "$TMPDIR/$FILENAME" -C "$FONT_DIR" ;;
    *.zip)    unzip -o "$TMPDIR/$FILENAME" -d "$FONT_DIR" ;;
esac

echo ":: Atualizando cache de fontes"
fc-cache "$FONT_DIR"

echo ":: Fontes instaladas:"
fc-list | grep "$FONT_NAME" | head -5
