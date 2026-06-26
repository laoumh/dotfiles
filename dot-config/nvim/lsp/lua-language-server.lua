-- Baseado em https://raw.githubusercontent.com/neovim/nvim-lspconfig/master/lsp/lua_ls.lua
-- Instalação do LSP:
-- :MasonInstall lua-language-server
---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { 'stylua.toml', '.stylua.toml', '.git' },
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = { enable = true, semicolon = 'Disable' },
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
}
