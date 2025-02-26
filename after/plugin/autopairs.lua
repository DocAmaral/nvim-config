
-- In your init.lua or a separate configuration file
local npairs = require('nvim-autopairs')

npairs.setup({
  check_ts = true,  -- This enables tree-sitter integration (optional)
  fast_wrap = {
    map = '<M-w>',  -- Keybinding for fast wrapping (optional)
  },
})

