--- Copiado de https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ruff.lua
---
--- Instalar `ruff` no ambiente virtual

---@type vim.lsp.Config
return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  settings = {},
}
