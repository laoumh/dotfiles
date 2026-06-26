-- Arquitetura:
--
-- vimtex: keymaps, error quickfix, syntax, indent, navigation
-- texlab LSP: completar, diagnóstico, busca/busca reversa
-- compilação: manual, via comando `latexmk`
-- Keymaps: ver after/ftplugins/tex.lua e lsp/texlab.lua

vim.pack.add({
  { src = 'https://github.com/lervag/vimtex' },
})

vim.g.vimtex_enabled = 1

-- Componentes desabilitados
vim.g.vimtex_compiler_enabled = 0
vim.g.vimtex_complete_enabled = 0
vim.g.vimtex_view_enabled = 0

-- Componentes habilitados
vim.g.vimtex_doc_handlers = { 'vimtex#doc#handlers#texdoc' }
vim.g.vimtex_indent_enabled = 1
vim.g.vimtex_mappings_enabled = 1

-- Não inclui 'K' (remapeado para <localleader>lk)
vim.g.vimtex_mappings_disable = { n = { 'K' } }
