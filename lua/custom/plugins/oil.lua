vim.pack.add {
  { src = 'https://github.com/stevearc/oil.nvim', version = vim.version.range '*' },
  -- 'https://github.com/nvim-mini/mini.icons', -- optional dependency for icons
  'https://github.com/nvim-tree/nvim-web-devicons', -- use if prefer nvim-web-devicons
}
require('oil').setup {
  keymaps = {
    ['<leader>`'] = {
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
      mode = 'n',
      desc = 'Open dir in tmux split',
    },
  },
}
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Oil' })

local oil_list_toggle = false
vim.keymap.set('n', '<leader>ol', function()
  oil_list_toggle = not oil_list_toggle
  if oil_list_toggle then
    require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
  else
    require("oil").set_columns({ "icon" })
  end
end, { desc = 'Toggle file details' })

vim.keymap.set('n', '<leader>yp', function()
  local oil = require 'oil'
  local file_path = oil.get_current_dir()
  if file_path == nil then
    file_path = vim.fn.expand('%:p')
    if file_path == '' then
      print('No file path to copy')
      return
    end
  end
  vim.fn.setreg('+', file_path)
  print('Copied file path to clipboard: ' .. file_path)
end, { desc = 'Copy file path to clipboard' }) 
