vim.pack.add {
  { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim', version = vim.version.range '*' },
  'https://github.com/github/copilot.vim', -- or zbirenbaum/copilot.lua
  'https://github.com/nvim-lua/plenary.nvim', -- for curl, log wrapper
}
require('CopilotChat').setup {
  mappings = {
    reset = {
      insert = '',
    },
  },
}
vim.keymap.set({'n', 'v'}, '<leader>cpe', '<cmd>CopilotChatExplain<cr>', { desc = 'Copilot Explain' })
vim.keymap.set({'n', 'v'}, '<leader>cpf', '<cmd>CopilotChatFix<cr>', { desc = 'Copilot Fix' })
vim.keymap.set({'n', 'v'}, '<leader>cpc', '<cmd>CopilotChat<cr>', { desc = 'Copilot Chat' })
vim.keymap.set({'n', 'v'}, '<leader>cpr', '<cmd>CopilotChatReset<cr>', { desc = 'Copilot Chat Reset' })
vim.keymap.set({'n', 'v'}, '<leader>cpq', '<cmd>CopilotChatClose<cr>', { desc = 'Copilot Chat Close' })
vim.keymap.set({'n', 'v'}, '<leader>cpo', '<cmd>CopilotChatOptimize<cr>', { desc = 'Copilot Chat Optimize' })
