local function exists(filename)
  local isPresent = true
  local f = io.open(filename)
  if not f then
    isPresent = false
  else
    f:close()
  end
  return isPresent
end

if exists 'project.godot' then
  print 'Starting Godot host...'
  vim.fn.serverstart './godothost'
end

local function run_with_function(cmd_template)
  local current_file = vim.api.nvim_buf_get_name(0)
  local pos = vim.lsp.util.make_position_params().position
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(),
  }
  vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, function(err, result, _, _)
    if err or not result then
      return
    end

    local function find_enclosing(symbols)
      local found
      for _, s in ipairs(symbols) do
        if s.range and pos.line >= s.range.start.line and pos.line <= s.range['end'].line then
          if s.kind == 12 or s.kind == 6 then
            found = s.name
          end
          if s.children then
            local child = find_enclosing(s.children)
            if child then
              found = child
            end
          end
        end
      end
      return found
    end

    local func_name = find_enclosing(result)
    if not func_name then
      print 'No enclosing function found'
      return
    end

    -- Replace a placeholder like {func} with the actual function name
    local cmd = cmd_template:gsub('{func}', func_name):gsub('{file}', current_file)
    os.execute("tmux split-window '" .. cmd .. "'")

    -- Store parameters for next run
    vim.g.last_run_with_command_funtion = cmd
  end)
end

-- Example keymap using a template
vim.keymap.set('n', '<leader>gut', function()
  run_with_function 'godot -s addons/gut/gut_cmdln.gd -d --path "$PWD" -gtest={file} -gunit_test_name={func} -glog=1'
end, { noremap = true, silent = true, desc = 'Run Godot Unit Test (GUT) for current function' })
vim.keymap.set('n', '<leader>gur', function()
  if vim.g.last_run_with_command_funtion then
    os.execute("tmux split-window '" .. vim.g.last_run_with_command_funtion .. "'")
  else
    print 'No previous test command found'
  end
end, { noremap = true, silent = true, desc = 'Re-run last Godot Unit Test (GUT) command' })

return {
  -- add the LSP server configuration through lspconfig
  {
    'neovim/nvim-lspconfig',
    ---@class PluginLspOpts
    opts = {
      -- ---@type lspconfig.options
      servers = {
        gdscript = {}, -- NOTE: To change the port, you need to set the environment variable GDScript_Port to the correct port number.
      },
    },
  },
  {
    'habamax/vim-godot',
    config = function()
      event = 'VimEnter'
    end,
  },
}
