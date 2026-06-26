--[[ CONFIG ]]
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true


--[[ LSP ]]
vim.schedule(function() vim.cmd('lsp enable lua-language-server') end)
