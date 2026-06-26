-- Configuração baseada em
--  - https://github.com/neovim/nvim-lspconfig/raw/refs/heads/master/lsp/texlab.lua
--  - https://github.com/neovim/nvim-lspconfig/raw/refs/heads/master/lsp/texlab.lua
--
-- Labels definidos via key-value (ex: lstlisting) não são reconhecidos.
-- Acompanhar: https://github.com/latex-lsp/texlab/issues/1159
--
-- Inverse search:
--   - No editor: <f4> (toggle_synctec)
--   - clique com mouse direito
-- Docs: https://sioyek-documentation.readthedocs.io/

local function buf_search(client, bufnr)
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
  client:request('textDocument/forwardSearch', params, function(err, result)
    if err then
      error(tostring(err))
    end
    local texlab_forward_status = {
      [0] = 'Success',
      [1] = 'Error',
      [2] = 'Failure',
      [3] = 'Unconfigured',
    }
    vim.notify('Search ' .. texlab_forward_status[result.status], vim.log.levels.INFO)
  end, bufnr)
end

local function dependency_graph(client)
  client:exec_cmd({ command = 'texlab.showDependencyGraph' }, { bufnr = 0 }, function(err, result)
    if err then
      return vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
    end
    vim.notify('The dependency graph has been generated:\n' .. result, vim.log.levels.INFO)
  end)
end


---@type vim.lsp.Config
return {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'plaintex', 'bib' },
  root_markers = { '.git', '.latexmkrc', 'latexmkrc' },
  settings = {
    texlab = {
      rootDirectory = nil,
      forwardSearch = {
        executable = 'sioyek',
        args = {
          "--reuse-window",
          "--execute-command",
          "toggle_synctex",
          "--inverse-search",
          "texlab inverse-search -i \"%%1\" -l %%2",
          "--forward-search-file",
          "%f",
          "--forward-search-line",
          "%l",
          "%p",
        },
      },
      chktex = {
        onOpenAndSave = true,
        onEdit = true,
      },
      diagnosticsDelay = 300,
      bibtexFormatter = 'texlab',
    },
  },
  on_attach = function(client, bufnr)
    for _, cmd in ipairs({
      { name = 'TexlabForward', fn = buf_search, desc = 'Forward search from current position' },
      { name = 'TexlabDependencyGraph', fn = dependency_graph, desc = 'Show the dependency graph' },
    }) do
      vim.api.nvim_buf_create_user_command(bufnr, 'Lsp' .. cmd.name, function()
        cmd.fn(client, bufnr)
      end, { desc = cmd.desc })
    end

    vim.keymap.set('n', '<localleader>lv', function() buf_search(client, bufnr) end,
      { buffer = bufnr, desc = 'Forward search' })
  end,
}
