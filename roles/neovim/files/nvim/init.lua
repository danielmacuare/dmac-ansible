require 'core.options'
require 'core.keymaps'

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require('lazy').setup {
  require 'plugins.catpuccin',
  require 'plugins.neo-tree',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.autoformatting',
  require 'plugins.signsgit',
  require 'plugins.alpha',
  require 'plugins.indent-blanklines',
  require 'plugins.misc',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.noice',
  require 'plugins.trouble',
  require 'plugins.todo-comments',
  require 'plugins.zen-mode',
}
