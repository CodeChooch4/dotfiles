return {
  {
    'folke/zen-mode.nvim',
    keys = {
      { '<leader>z', '<cmd>ZenMode<CR>', desc = 'Toggle ZenMode' },
    },
    opts = {
      window = {
        options = {
          number = true,
          relativenumber = true,
        },
      },
    },
  },
}
