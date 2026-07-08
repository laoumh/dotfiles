-- [[ Basic Keymaps ]]
--
--  See `:help vim.keymap.set()`

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--[[Ações]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Abre lista quickfix
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Mostra ou esconde diagnósticos
vim.keymap.set('n', '<leader>D', function ()
    -- bufnr = 0 --> somente buffer atual
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { desc = 'Toggle Diagnostics' })
-- Abre netrw
vim.keymap.set('n', '-', vim.cmd.Ex, { desc = 'Open netrw' })

--[[ Smart help (<F1>):
  - Se já está em uma página help, fecha
  - Tenta executar guess help
  - Se falha, executa help
]]
vim.keymap.set({'n', 'v', 'i'}, '<F1>',
  function()
    local ft = vim.filetype.match({
      buf = vim.api.nvim_get_current_buf()
    })
    if ft == 'help' then
      vim.cmd('bdelete')
      return
    end

    local ok, _ = pcall(function() vim.cmd('help!') end)
    if not ok then
      vim.cmd('help')
    end
  end,
  { desc = 'Smart help' }
)

-- LSP
vim.keymap.set('n', 'grh', function ()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end,
  { desc = 'Toggle inlay [h]ints' }
)
vim.keymap.set('n', 'gre', function ()
    vim.cmd('lsp enable')
    vim.print('LSP enabled')
  end,
  { desc = 'LSP [e]nable' }
)
vim.keymap.set('n', 'grd', function ()
    vim.cmd('lsp disable')
    -- Workaround: `:lsp disable` should stop running clients (per docs) but doesn't.
    -- Force-kill them manually. Remove when fixed upstream.
    vim.iter(vim.lsp.get_clients({ bufnr = 0 })):each(function(c) c:stop(true) end)
    vim.print('LSP disabled')
  end,
  { desc = 'LSP [d]isable' }
)


--[[Completion menu]]
vim.keymap.set('i', '<C-j>', function()
  return vim.fn.pumvisible() == 1 and '<Down>' or '<C-j>'
end, { expr = true, desc = 'Completion: next item' })

vim.keymap.set('i', '<C-k>', function()
  return vim.fn.pumvisible() == 1 and '<Up>' or '<C-k>'
end, { expr = true, desc = 'Completion: prev item' })

vim.keymap.set('i', '<CR>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true, desc = 'Completion: confirm' })

--[[Clipboard]]
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to system clipboard' })

--[[Atalhos de janela e abas]]
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Fecha a janela atual' })
-- vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>', { desc = 'Abre nova aba' })


--[[Diff mode]]
vim.keymap.set('n', 'dmb', '<cmd>diffget<CR>', { desc = 'Diff: get bloco' })
vim.keymap.set('n', 'dml', '<cmd>.,. diffget<CR>', { desc = 'Diff: get linha atual' })
vim.keymap.set('n', 'dmpb', '<cmd>diffput<CR>', { desc = 'Diff: put bloco' })
vim.keymap.set('n', 'dmpl', '<cmd>.,. diffput<CR>', { desc = 'Diff: put linha atual' })
vim.keymap.set('n', 'dmo', '<cmd>DiffOrig<CR>', { desc = 'Diff: changes to [o]riginal file' })
