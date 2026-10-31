vim.keymap.set({'n', 'v'}, '<leader>dg', '<cmd>diffget<cr>', { desc = 'diff get' })
vim.keymap.set({'n', 'v'}, '<leader>dp', '<cmd>diffput<cr>', { desc = 'diff put' })
vim.keymap.set('v', '<leader>dac', function()
  local lines = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = vim.fn.mode() })
  if vim.tbl_isempty(lines) then
    vim.notify('diff-clipboard: empty selection', vim.log.levels.WARN)
    return
  end
  local clip = vim.fn.getreg('+')
  local clip_lines = vim.split(clip, '\n', { plain = true, trimempty = true })
  if #clip_lines == 0 then
    vim.notify('diff-clipboard: clipboard is empty', vim.log.levels.WARN)
    return
  end
  local ext = vim.fn.expand('%:e')
  local suffix = ext ~= '' and ('.' .. ext) or ''
  local left  = vim.fn.tempname() .. suffix
  local right = vim.fn.tempname() .. suffix
  vim.fn.writefile(lines, left)
  vim.fn.writefile(clip_lines, right)
  local cmd = table.concat({
    'nvim', '-O', vim.fn.shellescape(left), vim.fn.shellescape(right),
    '-c', vim.fn.shellescape('windo diffthis'),
  }, ' ')
  if not vim.env.TMUX then
    vim.notify('diff-clipboard: not running inside tmux', vim.log.levels.ERROR)
  return
  end
  local status = os.execute(
    "tmux new-window -n diff -c '#{pane_current_path}' " .. vim.fn.shellescape(cmd))
  if status ~= 0 then
    vim.notify('diff-clipboard: failed to open tmux window', vim.log.levels.ERROR)
  end
end, { desc = 'diff selection against clipboard' })
