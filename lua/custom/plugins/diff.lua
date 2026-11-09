require('which-key').add {
  { '<leader>d', group = '[D]iff', mode = { 'n', 'v' } },
  { '<leader>da', group = '[D]iff [A]gainst', mode = { 'n', 'v' } },
}

vim.keymap.set({'n', 'v'}, '<leader>dg', '<cmd>diffget<cr>', { desc = '[D]iff [G]et' })
vim.keymap.set({'n', 'v'}, '<leader>dp', '<cmd>diffput<cr>', { desc = '[D]iff [P]ut' })
vim.keymap.set({'n', 'v'}, '<leader>do', '<cmd>diffoff!<cr>', { desc = '[D]iff [O]ff' })
vim.keymap.set({'n', 'v'}, '<leader>dt', '<cmd>windo diffthis<cr>', { desc = '[D]iff [W]indows' })

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
end, { desc = 'Diff selection [A]gainst [C]lipboard' })

vim.keymap.set('n', '<leader>dab', function()
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local cur_win = vim.api.nvim_get_current_win()

  require('telescope.builtin').buffers {
    sort_mru = true,               -- most-recently-used first
    ignore_current_buffer = true,  -- no point diffing against itself
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if not entry or not entry.bufnr then return end

        -- other buffer goes in a vertical split on the far right
        vim.cmd('botright vertical sbuffer ' .. entry.bufnr)
        local other_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_call(cur_win, function() vim.cmd 'diffthis' end)
        vim.api.nvim_win_call(other_win, function() vim.cmd 'diffthis' end)
      end)
      return true
    end,
  }
end, { desc = '[D]iff current buffer [A]gainst another [B]uffer' })
