# nvim-config

## Instalação

Ver script `./install_nvim`

### Dependências

- Utilitários: `git`, `make`, `unzip`, compilador C (`gcc`)
  - Instalar `build-essential`
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
  - Disponível no repositório Debian como `ripgrep`
- [fd](https://github.com/sharkdp/fd)
  - Disponível no repositório Debian como `fd-find`
- [fzf](https://github.com/junegunn/fzf)
  - Disponível no repositório Debian como `fzf`
- Clipboard tool (`xclip`/`wl-clipboard`)
- [Nerd Font](https://www.nerdfonts.com/)
  - Se instalado, configurar `vim.g.have_nerd_font`
  em `settings/settings.lua` para `true`
- Python: `pynvim` (para Vimspector)

### Clonar repositório

Clonar o arquivo de configuração em `~/.config/nvim`:

```sh
git clone git@github.com:laoumh/nvim-config.git "${HOME}/.config"/nvim
```

### Pós-instalação

Usar `:PackList` para listar plugins instalados.

Usar `:Mason` para administrar ferramentas (linter, lsp etc).

Usar `:lsp enable <nome>` para ativar um LSP configurado em `lsp/`.


## Uso remoto

Ao invés de instalar novamente no servidor,
possível montar o diretório remoto localmente com `sshfs`:

```sh
# Instala
sudo apt install sshfs

# Monta diretório remoto
sshfs [usuario@]<servidor_remoto>:</diretorio/projeto/alvo> <~/mnt/diretorio/projeto/local>

# Desmonta diretório remoto
fusermount -u <~/mnt/diretorio/projeto/local>
```

## Configuração antiga

O diretório `lua/config/languages/` contém configurações antigas (formato Lazy.nvim)
para LSPs ainda não migrados para `lsp/` (clangd, gopls, html, jsonls, cssls, ts_ls).
Pode ser removido quando todos os LSPs estiverem configurados.

