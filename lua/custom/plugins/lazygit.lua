vim.pack.add { { src = 'https://github.com/kdheepak/lazygit.nvim' }, 'https://github.com/nvim-lua/plenary.nvim' }
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGitCurrentFile<cr>', { desc = 'LazyGit' })
