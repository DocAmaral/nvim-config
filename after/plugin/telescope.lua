---@diagnostic disable: undefined-global
vim.g.mapleader = " " -- or your preferred leader key
local ok, telescope = pcall(require, 'telescope.builtin')
if not ok then return end

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>ss', function()
	builtin.grep_string({search = vim.fn.input("Grep>")})
end)
