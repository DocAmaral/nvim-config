---@diagnostic disable: undefined-global
---@type table

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then return end

-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
local capabilities = vim.tbl_deep_extend(
  'force',
  require('lspconfig').util.default_config.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- Setup navic
navic.setup {
  auto_attach = true,
}

-- Shared on_attach function
local on_attach = function(client, bufnr)
    -- Attach navic if the LSP supports document symbols
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    -- Keybindings for LSP
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end
require("lspconfig").ts_sp.setup({
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  settings = {
    typescript = {
      suggestionActions = {
        enabled = true
      },
      updateImportsOnFileMove = {
        enabled = "always"
      },
      implementationsCodeLens = {
        enabled = true
      },
      referencesCodeLens = {
        enabled = true
      },
      includeCompletionsForImportStatements = true,
      includeCompletionsWithSnippetText = true,
      includeAutomaticOptionalChainCompletions = true,
      includeCompletionsWithClassMemberSnippets = true,
      includeCompletionsWithObjectLiteralMethodSnippets = true
    },
    javascript = {
      suggestionActions = {
        enabled = true
      },
      updateImportsOnFileMove = {
        enabled = "always"
      },
      implementationsCodeLens = {
        enabled = true
      },
      referencesCodeLens = {
        enabled = true
      },
      includeCompletionsForImportStatements = true,
      includeCompletionsWithSnippetText = true,
      includeAutomaticOptionalChainCompletions = true,
      includeCompletionsWithClassMemberSnippets = true,
      includeCompletionsWithObjectLiteralMethodSnippets = true
    }
  }
})
-- Configure lua_ls for Neovim development
require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'}, -- Tell the language server that `vim` is a global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
-- npm install -g eslint (if not already installed)
require("lspconfig").eslint.setup({
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine"
      },
      showDocumentation = {
        enable = true
      }
    }
  }
})
require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {"E501"},
          maxLineLength = 120
        },
        pylint = {
          enabled = false
        },
        flake8 = {
          enabled = true
        },
        jedi = {
          environmentPath = vim.env.VIRTUAL_ENV, -- Important for virtual environments
        },
      },
    },
  },
  root_dir = require'lspconfig/util'.root_pattern("main.py","pyproject.toml", "setup.py", ".git"),
}
-- Export shared settings for use in server-specific configurations
return {
    lspconfig = lspconfig,
    on_attach = on_attach,
    capabilities = capabilities,
}
