-- Carrega configurações
require("settings.keymaps")
require("settings.settings")
require("settings.commands")

-- Carrega plugins síncronos
require("plugins-vimpack.colorschemes")
require("plugins-vimpack.vimtex")
require("plugins-vimpack.vimspector")

-- Carrega plugins assíncronos
-- intervalo de alguns milissegundos
vim.defer_fn(function ()
  require("plugins-vimpack.aerial")
  require("plugins-vimpack.fzf-lua")
  require("plugins-vimpack.gitsigns")
  require("plugins-vimpack.luasnip")
  require("plugins-vimpack.lint")
  require("plugins-vimpack.mason")
  require("plugins-vimpack.mini")
end, 20)

-- Carrega colorscheme depois do lazy, já que pode depender de plugins
-- require("settings.colorscheme")
