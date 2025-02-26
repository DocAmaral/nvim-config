
require('tokyonight').setup({
    -- Add any custom configuration here (optional)
    style = 'night', -- Choose from 'night', 'storm', 'day', 'moon'
    transparent = false, -- Enable transparency
    terminal_colors = true, -- Enable terminal colors
})
vim.cmd('colorscheme tokyonight') 
