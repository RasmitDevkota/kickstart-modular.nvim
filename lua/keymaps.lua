-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

--  Remapping jkl button smashes to escape insert mode
vim.keymap.set('i', 'jkl', '<Esc>')
vim.keymap.set('i', 'jlk', '<Esc>')
vim.keymap.set('i', 'kjl', '<Esc>')
vim.keymap.set('i', 'klj', '<Esc>')
vim.keymap.set('i', 'ljk', '<Esc>')
vim.keymap.set('i', 'lkj', '<Esc>')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '[c', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true })

local function insert_exam_question(num_parts)
  local lines = {
    '\\question .',
  }

  if num_parts > 0 then
    table.insert(lines, '\\begin{parts}')
    for i = 1, num_parts do
      table.insert(lines, '\t\\part .')
      table.insert(lines, '\t\\begin{solution}')
      table.insert(lines, '\t\t')
      table.insert(lines, '\t\\end{solution}')

      if i < num_parts then
        table.insert(lines, '\t')
      end
    end
    table.insert(lines, '\\end{parts}')
  else
    table.insert(lines, '\\begin{solution}')
    table.insert(lines, '\t')
    table.insert(lines, '\\end{solution}')
  end

  -- table.insert(lines, '')

  vim.api.nvim_put(lines, 'l', true, true)
end

-- Map the function to a command with an argument
vim.api.nvim_create_user_command('QP', function(opts)
  local num_parts = tonumber(opts.args) or 0
  insert_exam_question(num_parts)
end, { nargs = 1 })

-- vim: ts=2 sts=2 sw=2 et
