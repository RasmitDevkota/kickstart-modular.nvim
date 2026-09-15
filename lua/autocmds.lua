-- [[ Creating autocommands ]]
-- See `:help autocmd`

local function augroup(name)
  return vim.api.nvim_create_augroup("lazynvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('kickstart-highlight-yank'),
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('md'),
  pattern = { 'md' },
  callback = function()
    vim.cmd 'SoftPencil'

    vim.opt.conceallevel = 0

    vim.opt.foldmethod = 'indent'
  end,
})

-- Pressing <CR> right after `\begin{env}` inserts a matching `\end{env}` below the cursor,
-- unless the environment is already closed (begins and ends are balanced in the buffer)
local function tex_close_env_cr()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local before, after = line:sub(1, col), line:sub(col + 1)

  local env = before:match '\\begin{([^}]+)}[^\\]*$'
  if env and after:match '^%s*$' then
    local begin_pat, end_pat = '\\begin{' .. vim.pesc(env) .. '}', '\\end{' .. vim.pesc(env) .. '}'
    local depth = 0
    for _, l in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
      for _ in l:gmatch(begin_pat) do depth = depth + 1 end
      for _ in l:gmatch(end_pat) do depth = depth - 1 end
    end

    if depth > 0 then
      local indent = before:match '^%s*'
      local unit = vim.bo.expandtab and string.rep(' ', vim.fn.shiftwidth()) or '\t'
      vim.api.nvim_buf_set_lines(0, row - 1, row, false, { before, indent .. unit, indent .. '\\end{' .. env .. '}' })
      vim.api.nvim_win_set_cursor(0, { row + 1, #indent + #unit })
      return
    end
  end

  -- Otherwise behave like a normal <CR> (keeping nvim-autopairs' <CR> handling if it's loaded).
  -- The 'i' flag puts the keys at the front of the typeahead so they run before anything typed after
  local ok, autopairs = pcall(require, 'nvim-autopairs')
  vim.api.nvim_feedkeys(ok and autopairs.completion_confirm() or vim.keycode '<CR>', 'ni', false)
end

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('tex'),
  pattern = { 'tex' },
  callback = function(args)
    vim.keymap.set('i', '<CR>', tex_close_env_cr, { buffer = args.buf, desc = 'Auto-close LaTeX environment' })

    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4

    -- vim.g.vimtex_complete_close_braces = 1
    vim.g.vimtex_syntax_conceal_disable = 1

    vim.cmd 'SoftPencil'

    vim.opt.conceallevel = 0

    vim.opt.syntax = 'on'
    vim.opt.foldmethod = 'indent'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('python'),
  pattern = { 'python' },
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4

    vim.cmd 'SoftPencil'

    vim.opt.syntax = 'on'
    vim.opt.foldmethod = 'indent'

    -- vim.opt_local.tabstop = 4
    -- vim.opt_local.softtabstop = 4
    -- vim.opt_local.shiftwidth = 4
    --
    -- vim.cmd 'SoftPencil'
    --
    -- vim.opt_local.syntax = 'on'
    -- vim.opt_local.foldmethod = 'indent'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('c'),
  pattern = { 'c', 'h', 'cpp' },
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
