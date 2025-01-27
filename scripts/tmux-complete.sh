#!/bin/bash

# Instala autocompletar para tmux
# https://github.com/imomaliev/tmux-bash-completion?tab=readme-ov-file

dir="$HOME/.local/share/bash-completion/completions"
mkdir -p "$dir"
curl -fSL "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux" -o "$dir/tmux"

echo "tmux-bash-completion instalado em $dir"
echo "Recarregue .bashrc"

