-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    {
      '<leader>c',
      function()
        require('neo-tree.command').execute {
          action = 'focus',
          source = 'filesystem',
          position = 'float', -- Change to "left" if you prefer a sidebar
          dir = vim.fn.stdpath 'config', -- Opens the Neovim config folder
        }
      end,
      desc = 'Open Neovim config in NeoTree',
      silent = true,
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
      window = {
        position = 'float',
        mappings = {
          ['q'] = 'close_window',
          ['<leader>q'] = 'close_window',
        },
      },
    },
  },
}
