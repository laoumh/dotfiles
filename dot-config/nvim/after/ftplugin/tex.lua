--[[ CONFIG ]]
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.makeprg = 'latexmk'

--[[ LSP ]]
vim.schedule(function() vim.cmd('lsp enable texlab') end)

--[[ KEYMAPS ]]
-- Vimtex K (doc-package) moved to avoid conflict with LSP hover
vim.keymap.set('n', '<localleader>lk', '<plug>(vimtex-doc-package)', { buffer = true, desc = 'LaTex package documentation' })
