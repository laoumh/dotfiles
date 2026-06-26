
--[[
DOCS:
- LSP: Instalar `clangd` (disponível via apt)
--]]

-- LSP
require('lspconfig').clangd.setup({
  capabilities = require('utils.extend-capabilities'),
})

