-- [[ Autocommands ]]
-- DOCS: `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Sintaxe de arquivos de configuração SSH
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Set filetype for SSH config files',
  group = vim.api.nvim_create_augroup('ssh-config-ft', { clear = true }),
  pattern = '*/.ssh/config.*',
  command = 'setfiletype sshconfig',
})

-- `:help` abre à direita
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Open help in vertical split',
  group = vim.api.nvim_create_augroup('help-vsplit', { clear = true }),
  pattern = 'help',
  callback = function()
    vim.cmd.wincmd 'L'
  end,
})

-- Realça espaço em branco à direita, mas não quando em modo inserção
-- Ver `:help highlight-groups` para mais opções de cores
vim.api.nvim_create_autocmd({"WinEnter", "InsertLeave"}, {
  desc = "Highlight trailing spaces",
  group = vim.api.nvim_create_augroup("highlight-trail", { clear = true }),
  callback = function()
    vim.schedule(function()
      local is_floating_window = vim.api.nvim_win_get_config(0).relative ~= ''
      if not is_floating_window and not vim.w.trailing_whitespace_match then
        vim.w.trailing_whitespace_match = vim.fn.matchadd("Substitute", "\\s\\+$")
      end
    end)
  end,
})
vim.api.nvim_create_autocmd({"InsertEnter"}, {
  desc = "Remove highlight trailing spaces",
  group = vim.api.nvim_create_augroup("remove-highlight-trail", { clear = true }),
  callback = function()
    if vim.w.trailing_whitespace_match then
      vim.fn.matchdelete(vim.w.trailing_whitespace_match)
      vim.w.trailing_whitespace_match = nil
    end
  end,
})

-- Notifica alteração
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  desc = "Notifica arquivo alterado",
  group = vim.api.nvim_create_augroup("notifica-arquivo-alterado", { clear = true }),
  callback = function()
    vim.notify("Arquivo modificado. Recarregando.", vim.log.levels.INFO)
    local lib_exists, gitsigns = pcall(require, "gitsigns")
    if lib_exists then
      gitsigns.refresh()
    end
  end,
})

-- Habilita sugestões do LSP
-- Adaptado de exemplo em `:help lsp-attach`
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp.completion', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end
  end,
})


-- [[ User commands ]]

-- `:H` abre `help` em nova aba
vim.api.nvim_create_user_command('H', function(opts)
  vim.cmd('tab keepjumps help ' .. opts.args)
end, { nargs = '*', complete = 'help' })

-- vim.pack commands
vim.api.nvim_create_user_command('PackUpdate', function()
    vim.pack.update()
  end,
  { desc = "Atualiza plugins" }
)

vim.api.nvim_create_user_command('PackList', function()
    local plugins = vim.pack.get()
    if #plugins == 0 then
      vim.print("Nenhum plugin instalado")
      return
    end
    for _,p in ipairs(plugins) do
      local status = p.active and "ativo" or "inativo"
      vim.print(p.spec.name .. "\t" .. status)
    end
  end,
  { desc = "Lista plugins installados" }
)

vim.api.nvim_create_user_command('PackDel', function(opts)
    local plugin_name = opts.args
    local confirm = vim.fn.confirm("Excluir " .. plugin_name .. "?", "&Sim\n&Não", 2)
    if confirm == 1 then
      vim.pack.del({plugin_name})
      vim.print(plugin_name .. " removido.")
    end
  end,
  { desc = "Remove plugin",
    nargs = 1,
    complete = function()
      return vim.iter(vim.pack.get()):map(function(p) return p.spec.name end):totable()
    end
  }
)
