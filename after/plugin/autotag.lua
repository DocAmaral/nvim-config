require('nvim-ts-autotag').setup({
  enable = true, -- This is necessary to enable the plugin globally
  filetypes = { 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'xml' },
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Override individual filetype configs, these take priority
  per_filetype = {
    ["html"] = {
      enable_close = false -- Example override for HTML
    }
  }
})
