---@diagnostic disable: undefined-global
-- Lazy.nvim setup
 local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
 if not vim.loop.fs_stat(lazypath) then
	 vim.fn.system({
		 'git',
		 'clone',
		 '--filter=blob:none',
		 'https://github.com/folke/lazy.nvim.git',
		 '--branch=stable', -- Use the stable branch
		 lazypath,
	 })
 end
 vim.opt.rtp:prepend(lazypath)

 -- Plugin setup
 require('lazy').setup({
	 -- List your plugins here
	 {
		 'nvim-treesitter/nvim-treesitter',
		 run = ':TSUpdate', -- Ensure parsers are updated
		 config = function()
			 local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
			 if not ok then return end

			 treesitter.setup {
				 ensure_installed = { "javascript", "typescript", "go", "python", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
				 sync_install = false,
				 auto_install = true,
				 highlight = {
					 enable = true,
					 additional_vim_regex_highlighting = false,
				 },
			 }
		 end,
	 },
	 -- Telescope (fuzzy finder)
	 {
         'nvim-telescope/telescope.nvim',
         tag = '0.1.8',
         -- or branch = '0.1.x',
         dependencies = { 'nvim-lua/plenary.nvim' }
     },

     -- TokyoNight color scheme
     'folke/tokyonight.nvim',

     -- Harpoon (file navigation)
     'theprimeagen/harpoon',

     -- Undotree (undo history visualization)
     'mbbill/undotree',

     -- Indent-Blankline
     {
         "lukas-reineke/indent-blankline.nvim",
         main = "ibl",
         ---@module "ibl"
         ---@type ibl.config
         opts = {},
     },
     -- Fugitive (Git integration)
     'tpope/vim-fugitive',

     -- LSP configuration
     'neovim/nvim-lspconfig',

     -- Statusline/Winbar
	 {
         "SmiteshP/nvim-navic",
         dependencies = { 'SmiteshP/nvim-navic' }
     },

     -- Auto-Pairs (duplicate parenthesis and such)
     {
         'windwp/nvim-autopairs',
         event = "InsertEnter",
         config = true
         -- use opts = {} for passing setup options
         -- this is equivalent to setup({}) function
     },

     -- Auto-Tag (autoclose and autorename html tags)
     {
         'windwp/nvim-ts-autotag',
         dependencies = { 'nvim-treesitter/nvim-treesitter' },
         config = true
     },

	 -- ToggleTerm (terminal plugin)
	 {'akinsho/toggleterm.nvim', version = "*", config = true},

     -- Comments 
     {
         'numToStr/Comment.nvim',
         opts = {
             -- add any options here
         }
     },

	 -- nvim-cmp setup
	 {
		 'hrsh7th/nvim-cmp',
		 dependencies = {
			 'hrsh7th/cmp-nvim-lsp',
			 'hrsh7th/nvim-cmp',
			 'saadparwaiz1/cmp_luasnip',
			 'L3MON4D3/LuaSnip',
		 },
	 },

	 {
		 'williamboman/mason.nvim',
		 lazy=true,
		 build = ':MasonUpdate', -- Ensures the Mason registry stays updated
		 config = function()
			 require("mason").setup()
		 end
	 },

     {
         'nvim-lualine/lualine.nvim',
         dependencies = { 'nvim-tree/nvim-web-devicons' }
     },

	 'williamboman/mason-lspconfig.nvim',
 })

 -- Your other configurations
 require("jmrlglv")
