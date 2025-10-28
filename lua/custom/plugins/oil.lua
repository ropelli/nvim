return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Oil' },
    {
      '<leader>`',
      function()
        local oil = require 'oil'
        local dir = oil.get_current_dir()
        if dir == nil then
          print 'Could not determine current directory'
          return
        end
        local cmd_template = 'nvim -c "cd {dir}" -c ":e ."'
        local cmd = cmd_template:gsub('{dir}', dir)
        os.execute("tmux split-window -h '" .. cmd .. "'")
      end,
      desc = "Open a new nvim panel with the current buffer's directory using tmux",
    },
  },
}
