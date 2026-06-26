-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- UI
vim.g.have_nerd_font = true

vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.number = true
vim.opt.pumborder = 'rounded'
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.winborder = 'rounded'

vim.cmd.colorscheme 'catppuccin'
require('vim._core.ui2').enable()

-- Config
vim.opt.exrc = true
vim.opt.mouse = ''

-- Editing
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.undofile = true
vim.opt.wrap = true

vim.schedule(function()
  vim.opt.spelllang = 'en_us,pt_br'
  vim.opt.spell = true
end)

-- Search
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.smartcase = true

-- Splits & scrolling
vim.opt.scrolloff = 10
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Completion
vim.opt.autocomplete = false
vim.opt.completeopt = { 'menu', 'menuone', 'fuzzy', 'noinsert', 'noselect', 'popup' }

-- Diagnostics
vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

-- Diff
vim.opt.diffopt:append{'followwrap'}

-- Timing
vim.opt.autoread = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 1000
