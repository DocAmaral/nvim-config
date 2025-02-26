---@diagnostic disable: undefined-global
local navic = require("nvim-navic")

-- Setup navic with optional config
navic.setup {
  highlight = true,      -- Adds highlighting for breadcrumbs
  separator = " > ",     -- Visual separator
  depth_limit = 5,       -- Limits how many breadcrumb levels show
}

-- Attach navic only if the LSP supports document symbols
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, event.buf)
      end
  end,
})

-- Define a global function to get the winbar content
_G.get_winbar = function()
    local location = require('nvim-navic').get_location()
    if location ~= '' then
        return location
    else
        local filename = vim.fn.expand('%:t')
        local filetype = vim.bo.filetype
        -- Get appropriate icon for the filetype
        local icon = ''
        local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
        if has_devicons and filename ~= '' then
            local ext = vim.fn.fnamemodify(filename, ':e')
            local icon_str, icon_color = devicons.get_icon_color(filename, ext, { default = true })
            if icon_str then
                icon = icon_str .. ' '
            end
        else
            -- Fallback icons if devicons not available
            local filetype_icons = {
                lua = '󰢱',
                python = '󰌠',
                javascript = '󰌞',
                typescript = '󰛦',
                html = '󰌝',
                css = '󰌜',
                rust = '󱘗',
                go = '󰟓',
                markdown = '󰍔',
                json = '󰘦',
                yaml = '󰘦',
                toml = '󰘦',
                -- Add more as needed
                default = '󰈔'
            }
            icon = (filetype_icons[filetype] or filetype_icons.default) .. ' '
        end
        -- If we're in a named buffer
        if filename ~= '' then
            return string.format(" %%#NavicIconsFile#%s%%#NavicText# %s",
                                 icon, filename, filetype ~= '' and filetype or 'plain')
        else
            return " %#NavicIconsFile#󰈙 %#NavicText#"
        end
    end
end

-- Set the winbar option using the global function
vim.o.winbar = "%{%v:lua.get_winbar()%}"
