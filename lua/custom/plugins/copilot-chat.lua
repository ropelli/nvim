vim.pack.add {
  { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim', version = vim.version.range 'master' },
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
require('which-key').add {
  { '<leader>cp', group = '[C]o[P]ilot', mode = { 'n', 'v' } },
}
vim.keymap.set({'n', 'v'}, '<leader>cpc', '<cmd>CopilotChat<cr>', { desc = '[C]o[P]ilot [C]hat' })
vim.keymap.set({'n', 'v'}, '<leader>cpe', '<cmd>CopilotChatExplain<cr>', { desc = '[C]o[P]ilot [E]xplain' })
vim.keymap.set({'n', 'v'}, '<leader>cpf', '<cmd>CopilotChatFix<cr>', { desc = '[C]o[P]ilot [F]ix' })
vim.keymap.set({'n', 'v'}, '<leader>cpo', '<cmd>CopilotChatModels<cr>', { desc = '[C]o[P]ilot Chat [M]odels' })
vim.keymap.set({'n', 'v'}, '<leader>cpo', '<cmd>CopilotChatOptimize<cr>', { desc = '[C]o[P]ilot Chat [O]ptimize' })
vim.keymap.set({'n', 'v'}, '<leader>cpq', '<cmd>CopilotChatClose<cr>', { desc = '[C]o[P]ilot Chat [C]lose' })
vim.keymap.set({'n', 'v'}, '<leader>cpr', '<cmd>CopilotChatReset<cr>', { desc = '[C]o[P]ilot Chat [R]eset' })
