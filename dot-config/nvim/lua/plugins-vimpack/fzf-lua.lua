vim.pack.add({ 'https://github.com/ibhagwan/fzf-lua' })

local fzf = require('fzf-lua')
fzf.setup({
  'max-perf',
  keymap = {
    fzf = {
      ['ctrl-q'] = 'select-all+accept',
    },
  },
  keymaps = {
    ignore_patterns = false,
  },
})

fzf.register_ui_select()

-- Search
vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sn', function() fzf.files({cwd=vim.fn.stdpath("config")}) end, { desc = '[S]earch [N]vim config' })
vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sd', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files' })
vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect fzf-lua' })
vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Search in current buffer' })
vim.keymap.set('n', '<leader>s/', fzf.lines, { desc = '[S]earch [/] in open buffers' })

-- LSP symbols
vim.keymap.set('n', '<leader>so', fzf.lsp_document_symbols, { desc = '[S]earch document symb[O]ls' })
