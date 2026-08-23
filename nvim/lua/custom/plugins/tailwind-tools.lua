-- tailwind-tools.lua
return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- optional
  },
  ft = {
    'html',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
    'php',
    'markdown',
    'mdx'
  },
  opts = {
    document_color = {
      enabled = true,
      kind = "foreground",
    },
    conceal = {
      enabled = false,
    },
    server = {
      override = false, -- Avoid deprecated lspconfig API
    },
  },
}
