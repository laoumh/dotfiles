vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

require('gitsigns').setup({
  word_diff = false,
  on_attach = function(bufnr)
    local gs = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gs.nav_hunk('next', { target = 'all' })
      end
    end, { desc = 'Next [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gs.nav_hunk('prev', { target = 'all' })
      end
    end, { desc = 'Previous [c]hange' })

    -- Stage / reset
    map('n', '<leader>gs', gs.stage_hunk, { desc = 'git [s]tage hunk' })
    map('v', '<leader>gs', function()
      gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'git [s]tage hunk' })
    map('n', '<leader>gr', gs.reset_hunk, { desc = 'git [r]eset hunk' })
    map('v', '<leader>gr', function()
      gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'git [r]eset hunk' })

    -- Preview / diff / blame
    map('n', '<leader>gp', gs.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>gb', gs.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>gd', gs.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>gD', function() gs.diffthis('@') end, { desc = 'git [D]iff against last commit' })
  end,
})
