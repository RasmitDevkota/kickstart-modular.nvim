-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,     -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        TODO = { icon = " ", color = "test", alt = { "TODO" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        NOTE = { icon = " ", color = "hint", alt = { "NOTE" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TEST" } },
      },
      gui_style = {
        fg = "NONE",         -- The gui style to use for the fg highlight group.
        bg = "BOLD",         -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true,              -- enable multine todo comments
        multiline_pattern = "^.",      -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,        -- extra lines that will be re-evaluated when changing a line
        before = "fg",                 -- "fg" or "bg" or empty
        keyword = "bg",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",                  -- "fg" or "bg" or empty
        pattern = [[\@(KEYWORDS) - ]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true,          -- uses treesitter to match keywords in comments only
        max_line_len = 400,            -- ignore lines longer than this
        exclude = {},                  -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" }, -- @WARN -
        info = { "DiagnosticInfo", "#2563EB" },                  -- @TODO -
        hint = { "DiagnosticHint", "#10B981" },                  -- @NOTE -
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },                      -- @TEST -
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        pattern = [[\@(KEYWORDS)]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    }
  },
}
-- vim: ts=2 sts=2 sw=2 et
