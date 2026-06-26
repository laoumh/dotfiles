-- DOCS:
-- Friendly snippets:
--  - Repo: 'rafamadriz/friendly-snippets'
--  - Package: https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
--  - Snippets: https://github.com/rafamadriz/friendly-snippets/tree/main/snippets
-- Tutorial:
--  - https://ejmastnak.com/tutorials/vim-latex/luasnip/

-- Se em algum momento for necessário snippets com expressões regulares, necessário instalar `jsregexp`
-- Ver `:help PackChanged` para mais detalhes sobre a abordagem
-- vim.api.nvim_create_autocmd('PackChanged', {
--   callback = function(ev)
--     if ev.data.spec.name == 'LuaSnip' and ev.data.kind ~= 'delete' then
--       vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path }):wait()
--     end
--   end,
-- })

vim.pack.add({
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('>=0') },
})

local ls = require('luasnip')
ls.setup({
  enable_autosnippets = true,
  store_selection_keys = '<Tab>',
})

require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/nvim/snippets/vscode-snippets/' } })
require('luasnip.loaders.from_lua').lazy_load({ paths = { '~/.config/nvim/snippets/luasnippets/' } })

-- Snippet navigation
vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if ls.expand_or_locally_jumpable() then ls.expand_or_jump() end
end, { desc = 'Snippet: jump forward' })

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if ls.locally_jumpable(-1) then ls.jump(-1) end
end, { desc = 'Snippet: jump backward' })

-- Snippet completion via completefunc (<C-x><C-u>)
vim.opt.completefunc = 'v:lua.LuaSnip_completefunc'
vim.opt.complete:append('F')

function LuaSnip_completefunc(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local start = col
    while start > 0 and line:sub(start, start):match('[%w_-]') do
      start = start - 1
    end
    return start
  end

  local ft = vim.bo.filetype
  local snips = ls.get_snippets(ft) or {}
  local all = ls.get_snippets('all') or {}
  vim.list_extend(snips, all)

  local items = {}
  for _, snip in ipairs(snips) do
    if snip.trigger:find(base, 1, true) == 1 then
      local doc = snip:get_docstring()
      table.insert(items, {
        word = snip.trigger,
        menu = '[snip]',
        info = type(doc) == 'table' and table.concat(doc, '\n') or doc or '',
      })
    end
  end
  return items
end

-- Auto-expand snippet after selecting from completion menu
vim.api.nvim_create_autocmd('CompleteDone', {
  callback = function()
    local item = vim.v.completed_item
    if item and item.menu == '[snip]' and ls.expandable() then
      ls.expand()
    end
  end,
})
