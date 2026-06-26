-- Diff current buffer against the saved file on disk
-- See `:help :DiffOrig`

vim.api.nvim_create_user_command('DiffOrig', function()
  local fname = vim.fn.expand('%:p')
  local content = vim.fn.readfile(fname)
  local winID = vim.api.nvim_get_current_win()
  local bufID = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_get_option_value('filetype', { buf = bufID })

  local newbufID = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(newbufID, true, { split = 'left', win = winID })
  vim.api.nvim_set_option_value('filetype', ft, { buf = newbufID })
  vim.api.nvim_put(content, '', false, false)
  vim.cmd.diffthis()

  vim.api.nvim_set_current_win(winID)
  vim.cmd.diffthis()
end, { desc = 'Diff buffer against saved file' })
