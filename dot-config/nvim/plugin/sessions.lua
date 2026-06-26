local default_session = 'session.nvim'

local function session_path(name)
  return vim.fn.fnameescape(vim.fn.getcwd() .. '/' .. (name or default_session))
end

vim.api.nvim_create_user_command('MakeSession', function(opts)
  local path = session_path(opts.fargs[1])
  if vim.fn.filereadable(path) == 1 then
    if vim.fn.confirm('Session exists. Overwrite?', '&Yes\n&No') ~= 1 then return end
  end
  vim.cmd('mksession! ' .. path)
  vim.notify('Session saved: ' .. path)
end, { nargs = '?', desc = 'Save session' })

vim.api.nvim_create_user_command('LoadSession', function(opts)
  local path = session_path(opts.fargs[1])
  if vim.fn.filereadable(path) ~= 1 then
    return vim.notify('No session found: ' .. path, vim.log.levels.WARN)
  end
  vim.cmd('source ' .. path)
  vim.notify('Session loaded: ' .. path)
end, { nargs = '?', desc = 'Load session' })

vim.keymap.set('n', '<leader>ms', '<cmd>MakeSession<CR>', { desc = '[M]ake [S]ession' })
vim.keymap.set('n', '<leader>ml', '<cmd>LoadSession<CR>', { desc = '[M]ake [L]oad session' })
