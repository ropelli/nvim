vim.pack.add { { src = 'https://github.com/kdheepak/lazygit.nvim' }, 'https://github.com/nvim-lua/plenary.nvim' }
vim.keymap.set('n', '<leader>lg', 
  function()
    local path = vim.api.nvim_buf_get_name(0)
    -- if oil buffer is open, use oils path, otherwise use current buffer path
    if vim.bo.filetype == 'oil' then
      local path_no_oil = path:gsub('oil://', '')
      local git_path = require("lazygit.utils").get_root(path_no_oil)
      require('lazygit').lazygit(git_path)
      return
    end
    require('lazygit').lazygitcurrentfile()
  end,
  { desc = 'LazyGit' })
