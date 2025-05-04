-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
    'kiyoon/treesitter-indent-object.nvim',
    keys = {
      {
        'ai',
        function()
          require('treesitter_indent_object.textobj').select_indent_outer()
        end,
        mode = { 'x', 'o' },
        desc = 'Select context-aware indent (outer)',
      },
      {
        'aI',
        function()
          require('treesitter_indent_object.textobj').select_indent_outer(true)
        end,
        mode = { 'x', 'o' },
        desc = 'Select context-aware indent (outer, line-wise)',
      },
      {
        'ii',
        function()
          require('treesitter_indent_object.textobj').select_indent_inner()
        end,
        mode = { 'x', 'o' },
        desc = 'Select context-aware indent (inner, partial range)',
      },
      {
        'iI',
        function()
          require('treesitter_indent_object.textobj').select_indent_inner(true, 'V')
        end,
        mode = { 'x', 'o' },
        desc = 'Select context-aware indent (inner, entire range) in line-wise visual mode',
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    tag = 'v2.20.8', -- Use v2
    event = 'BufReadPost',
    config = function()
      vim.opt.list = true
      require('indent_blankline').setup {
        space_char_blankline = ' ',
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/cmp',

  -- require 'kickstart/plugins/tokyonight',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  -- require 'kickstart/plugins/treesitter',

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
  --
  -- 'nvim-treesitter/nvim-treesitter-context',

  {
    'amitds1997/remote-nvim.nvim',
    version = '*', -- Pin to GitHub releases
    dependencies = {
      'nvim-lua/plenary.nvim', -- For standard functions
      'MunifTanjim/nui.nvim', -- To build the plugin UI
      'nvim-telescope/telescope.nvim', -- For picking b/w different remote methods
    },
    config = true,
  },

  require 'custom/plugins/darkrose',

  require 'custom/plugins/vim-pencil',

  {
    'lervag/vimtex',
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- vim.g.vimtex_view_method = 'zathura'
      vim.opt.syntax = 'on'
      -- vim.opt.conceallevel = 0

      vim.g.vimtex_complete_close_braces = 1
      vim.g.vimtex_syntax_conceal_disable = 1
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
    end,
  },

  {
    'micangl/cmp-vimtex',
    lazy = false,
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
