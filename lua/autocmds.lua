-- [[ Creating autocommands ]]
-- See `:help autocmd`

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'tex' },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4

    -- vim.g.vimtex_complete_close_braces = 1
    vim.g.vimtex_syntax_conceal_disable = 1

    vim.cmd 'SoftPencil'

    vim.opt.conceallevel = 0

    vim.opt.syntax = 'on'
    vim.opt.foldmethod = 'syntax'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'py' },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4

    vim.cmd 'SoftPencil'

    vim.opt.syntax = 'on'
    vim.opt.foldmethod = 'indent'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
