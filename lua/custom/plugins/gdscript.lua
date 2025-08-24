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
