require ('toggleterm').setup {
	direction = 'horizontal',
	open_mapping = [[<F12>]],
	shade_terminals = true,
	float_opts = {
		border = 'rounded',
	}
}
-- First terminal (floating, triggered by F12)
vim.api.nvim_set_keymap('n', '<F12>', ':ToggleTerm 1  direction=horizontal<CR>', { noremap = true, silent = true })

-- Second terminal (horizontal, triggered by F11)
vim.api.nvim_set_keymap('n', '<F11>', ':ToggleTerm 2 direction=horizontal<CR>', { noremap = true, silent = true })
