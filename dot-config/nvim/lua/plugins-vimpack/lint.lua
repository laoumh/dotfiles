vim.pack.add{
  { src = 'https://codeberg.org/mfussenegger/nvim-lint' },
}

require('lint').linters_by_ft = {
  bash = { 'shellcheck' },
  sh = { 'shellcheck' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function()
    require('lint').try_lint()
  end,
})
