
vim.pack.add({
  { src = 'https://github.com/stevearc/aerial.nvim', version = 'stable'},
})

local aerial = require('aerial')
aerial.setup({
  layout = {
    default_direction = 'prefer_left',
  },
})

-- keymaps
vim.keymap.set('n', '\\', aerial.toggle, { desc = "Code outline" })
vim.keymap.set('n', '<leader>\\', aerial.nav_toggle, { desc = "Code outline picker" })
