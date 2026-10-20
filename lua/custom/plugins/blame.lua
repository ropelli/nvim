vim.pack.add {
  { src = 'https://github.com/FabijanZulj/blame.nvim' },
}
require('blame').setup {}
vim.keymap.set({'n', 'v'}, '<leader>gb', '<cmd>BlameToggle<cr>', { desc = 'Git Blame' })
