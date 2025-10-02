return {
  {
    'github/copilot.vim',

    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set('i', '<M-j>', 'copilot#Next()', {
        desc = 'Copilot Previous Suggestion',
        expr = true,
        silent = true,
      })
      vim.keymap.set('i', '<M-k>', 'copilot#Previous()', {
        desc = 'Copilot Previous Suggestion',
        expr = true,
        silent = true,
      })
      vim.keymap.set('i', '<M-l>', 'copilot#AcceptWord()', {
        desc = 'Copilot Accept Word',
        expr = true,
        silent = true,
        replace_keycodes = false,
      })
      vim.keymap.set('i', '<C-l>', 'copilot#Accept()', {
        desc = 'Copilot Accept Suggestion',
        expr = true,
        silent = true,
        replace_keycodes = false,
      })
    end,
  },
}
