vim.pack.add {
  { src = 'https://github.com/stevearc/oil.nvim', version = vim.version.range '*' },
  -- 'https://github.com/nvim-mini/mini.icons', -- optional dependency for icons
  'https://github.com/nvim-tree/nvim-web-devicons', -- use if prefer nvim-web-devicons
}

require("oil.columns").register("git-commit-date", {
  render = function(entry, conf)
    local name = entry[2]
    local type = entry[3]
    if type == "directory" or type == "file" then
      local dir = require("oil").get_current_dir()
      if dir == nil then
        return { "N/A", "Error" }
      end
      local dir_no_prefix = dir:gsub('^oil://', '')
      local result = vim.system(
        { "git", "log", "-1", '--pretty=%cs %an', '--', name },
        { cwd = dir_no_prefix }
      ):wait()
      if result.code ~= 0 then
        return { "N/A", "Error" }
      end
      local date = result.stdout:gsub('\n', '')
      return { date, date }
    end
    return { "", "foo" }
  end,

  parse = function(line, conf)
      return line:match("^(%S+)%s+(.*)$")
  end,
})

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
    ['<leader>z'] = {
      function()
        local oil = require 'oil'
        local actions = require 'oil.actions'
        local entry = oil.get_cursor_entry()
        if entry == nil then
          print 'No file under cursor'
          return
        end
        if entry.type ~= 'file' then
          print 'Selected entry is not a file'
          return
        end
        if entry.name:sub(-4) ~= '.zip' then
          print 'Selected file is not a zip file'
          return
        end
        local dir = oil.get_current_dir()
        if dir == nil then
          print 'Could not determine current directory'
          return
        end
        local dir_without_oil_prefix = dir:gsub('^oil://', '')
        local file_path = dir_without_oil_prefix .. '/' .. entry.name
        local extract_dir = dir_without_oil_prefix .. '/' .. entry.name:gsub('%.zip$', '')
        local cmd_template = 'unzip "{file}" -d "{dir}"'
        local cmd = cmd_template:gsub('{file}', file_path):gsub('{dir}', extract_dir)
        os.execute(cmd)
        print('Extracted ' .. entry.name .. ' to ' .. extract_dir)
      end,
      mode = 'n',
      desc = 'Unzip zip file here',
    }
  },
}
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Oil' })

local oil_extensions = {}
local oil_list_toggle = false
local oil_git_toggle = false
vim.keymap.set('n', '<leader>ol', function()
  oil_list_toggle = not oil_list_toggle
  oil_extensions.set_columns()
end, { desc = 'Toggle file details' })

oil_extensions.set_columns = function()
  if oil_list_toggle then
    if oil_git_toggle then
      require("oil").set_columns({ "icon", "permissions", "size", "mtime", "git-commit-date" })
    else
      require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
    end
  else
    if oil_git_toggle then
      require("oil").set_columns({ "icon", "git-commit-date" })
    else
      require("oil").set_columns({ "icon" })
    end
  end
end

vim.keymap.set('n', '<leader>og', function()
  oil_git_toggle = not oil_git_toggle
  oil_extensions.set_columns()
end, { desc = 'Toggle git details' })

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
