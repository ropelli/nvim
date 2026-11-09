-- Here we load anything that is in the ~/.config/nvim_work_extensions directory.
-- The work extension should be installed in a following layout:
-- ~/.config/nvim_work_extensions/
-- ├── lua/
-- │   └── work_extensions/
--         └── init.lua
--         └── some_other_file.lua
-- In the init.lua file, you can require any other files in the work_extensions directory
-- with `require("work_extensions.some_other_file")`.

local work_extensions_path = vim.fn.expand("~/.config/nvim_work_extensions")
if vim.fn.isdirectory(work_extensions_path) == 1 then
  vim.opt.runtimepath:append(work_extensions_path)
  local ok, err = pcall(require, "work_extensions")
  if not ok and not tostring(err):find("module 'work_extensions' not found", 1, true) then
    vim.notify("Failed to load work_extensions: " .. tostring(err), vim.log.levels.WARN)
  end
end
