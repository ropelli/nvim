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
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      { '<leader>cpe', '<cmd>CopilotChatExplain<cr>', desc = 'Copilot Explain' },
      { '<leader>cpf', '<cmd>CopilotChatFix<cr>', desc = 'Copilot Fix' },
      { '<leader>cpc', '<cmd>CopilotChat<cr>', desc = 'Copilot Chat' },
    },
  },
}
