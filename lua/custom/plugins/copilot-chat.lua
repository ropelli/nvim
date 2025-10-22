return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    lazy = false,
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      mappings = {
        reset = {
          insert = '',
        },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      { '<leader>cpe', '<cmd>CopilotChatExplain<cr>', mode = { 'n', 'v' }, desc = 'Copilot Explain' },
      { '<leader>cpf', '<cmd>CopilotChatFix<cr>', mode = { 'n', 'v' }, desc = 'Copilot Fix' },
      { '<leader>cpc', '<cmd>CopilotChat<cr>', mode = { 'n', 'v' }, desc = 'Copilot Chat' },
      { '<leader>cpr', '<cmd>CopilotChatReset<cr>', mode = { 'n', 'v' }, desc = 'Copilot Chat Reset' },
      { '<leader>cpq', '<cmd>CopilotChatClose<cr>', mode = { 'n', 'v' }, desc = 'Copilot Chat Close' },
      { '<leader>cpo', '<cmd>CopilotChatOptimize<cr>', mode = { 'n', 'v' }, desc = 'Copilot Chat Optimize' },
    },
  },
}
