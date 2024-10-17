return {
  {
    'water-sucks/darkrose.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'darkrose'

      vim.cmd [[highlight Normal guibg=#0a0a0a]]
      vim.cmd [[highlight NonText guibg=#0a0a0a]]
      vim.cmd [[highlight SignColumn guibg=#0a0a0a]]
      vim.cmd [[highlight TreesitterContext guibg=#010101]]
      vim.cmd [[highlight TreesitterContextLineNumber guibg=#010101]]

      vim.cmd [[highlight @Variable guifg=#bbbbbb]]
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
