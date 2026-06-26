vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable'},
})

require('mini.ai').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.icons').setup()

-- [[ mini.clue ]]
-- local miniclue = require('mini.clue')
-- miniclue.setup({
--   triggers = {
--     { mode = 'n', keys = '<Leader>' },
--     { mode = 'x', keys = '<Leader>' },
--     { mode = 'n', keys = 'g' },
--     { mode = 'x', keys = 'g' },
--     { mode = 'n', keys = '[' },
--     { mode = 'n', keys = ']' },
--     { mode = 'n', keys = '<C-w>' },
--     { mode = 'n', keys = 'z' },
--     { mode = 'x', keys = 'z' },
--   },
--
--   clues = {
--     miniclue.gen_clues.g(),
--     miniclue.gen_clues.square_brackets(),
--     miniclue.gen_clues.windows(),
--     miniclue.gen_clues.z(),
--     -- Group descriptions for your <Leader> mappings
--     { mode = 'n', keys = '<Leader>s', desc = '+Search' },
--     { mode = 'n', keys = '<Leader>g', desc = '+Git' },
--   },
--
--   window = { delay = 900 },
-- })

-- [[ mini.statusline ]]
local statusline = require('mini.statusline')

local function get_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv then
    venv = '(' .. vim.fn.fnamemodify(venv, ':t') .. ')'
  end
  return venv
end

local function section_lsp()
  local names = vim.iter(vim.lsp.get_clients({ bufnr = 0 })):map(function(c) return c.name end):totable()
  local lsp = #names > 0 and table.concat(names, '|') or 'LSP off'
  return lsp
end

local function section_filename(args)
  if statusline.is_truncated(args.trunc_width) then
    return '%t %m%r'
  end
  return '%f %m%r'
end

local function section_bufcount()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local unsaved = vim.iter(bufs):filter(function(b) return b.changed == 1 end):fold(0, function(n) return n + 1 end)
  if unsaved > 0 then
    return string.format('[%d buf, %d unsaved]', #bufs, unsaved)
  end
  return string.format('[%d buf]', #bufs)
end

local function section_fileinfo()
  local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
  local venv = get_venv()
  if venv then
    fileinfo = venv .. " " .. fileinfo
  end
  return fileinfo
end

statusline.setup({
  use_icons = vim.g.have_nerd_font,
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git           = statusline.section_git({ trunc_width = 40 })
      local diff          = statusline.section_diff({ trunc_width = 75 })
      local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
      local lsp           = section_lsp()
      local filename      = section_filename({ trunc_width = 140 })
      local bufcount      = section_bufcount()
      local fileinfo      = section_fileinfo()
      local location      = '%2l:%-2v %P'
      local search        = statusline.section_searchcount({ trunc_width = 75 })

      return statusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MinistatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
        '%<',
        { hl = 'MinistatuslineFilename', strings = { filename, bufcount } },
        '%=',
        { hl = 'MinistatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end,
  },
})
