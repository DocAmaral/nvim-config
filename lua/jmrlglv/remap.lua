vim.g.mapleader= " "
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

-- Map Alt-v to Visual Block Mode
vim.keymap.set('n', '<M-v>', '<C-v>') -- Alt-v enters Visual Block Mode in normal mode

-- Exit insert mode with double Shift
vim.keymap.set('i', 'jk', '<Esc>') -- Press jk fast to exit insert mode

--Make Ctrl-c and Ctrl-v behave like typical copy-paste
vim.keymap.set('v', '<C-c>', '"+y') -- Copy
vim.keymap.set('n', '<C-v>', '"+p') -- Paste in normal mode
vim.keymap.set('v', '<C-v>', '"+p') -- Paste in visual mode
vim.keymap.set('i', '<C-v>', '<C-r>+') -- Paste in insert mode

