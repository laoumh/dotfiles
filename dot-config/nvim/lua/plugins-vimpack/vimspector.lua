-- Necessário instalar pynvim
-- Configuração:
--   - arquivo `.vimspector.json` na raiz do projeto
--   - ver https://puremourning.github.io/vimspector/configuration.html
if vim.fn.has('python3') == 0 then return end

vim.g.vimspector_enable_mappings = 'HUMAN'

vim.pack.add({
  { src = 'https://github.com/puremourning/vimspector' },
}, { load = true })

vim.keymap.set('n', '<leader>di', '<Plug>VimspectorBalloonEval', { desc = 'Debug: inspect' })
vim.keymap.set('x', '<leader>di', '<Plug>VimspectorBalloonEval', { desc = 'Debug: inspect' })
