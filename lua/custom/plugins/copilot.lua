return {
  {
    'github/copilot.vim',

    config = function()
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
      })
    end,
  },
}
