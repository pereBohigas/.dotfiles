-- Auto installation of lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	--- APPEARANCE ---
	-- Lualine -> https://github.com/nvim-lualine/lualine.nvim
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	--- Gruvbox -> https://github.com/ellisonleao/gruvbox.nvim
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true
	},
	-- Treesitter -> https://github.com/nvim-treesitter/nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"bash",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			}
		}
	},
	--- Indent Blankline -> https://github.com/lukas-reineke/indent-blankline.nvim
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
	--- Scrollbar -> https://github.com/petertriho/nvim-scrollbar
	{
		"petertriho/nvim-scrollbar",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"ellisonleao/gruvbox.nvim"
		}
	},
	--- NAVIGATION ---
	-- Telescope -> https://github.com/nvim-telescope/telescope.nvim
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end
		}
	},
	-- Harpoon -> https://github.com/ThePrimeagen/harpoon
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2", -- taking version 2 directly from branch
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	-- Window Picker -> https://github.com/s1n7ax/nvim-window-picker
	{
		's1n7ax/nvim-window-picker',
		name = 'window-picker',
		event = 'VeryLazy',
		version = '2.*',
		config = function()
			require'window-picker'.setup()
		end
	},
	-- Undotree -> https://github.com/mbbill/undotree
	{
		"mbbill/undotree"
	},
	--- TEX EDITING ---
	-- Comment  -> https://github.com/numToStr/Comment.nvim
	{
		"numToStr/Comment.nvim",
		lazy = false
	},
	-- nvim-cmp -> https://github.com/hrsh7th/nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji"
		}
		-- ---@param opts cmp.ConfigSchema
		-- opts = function(_, opts)
		-- 	table.insert(opts, { name = "emoji" })
		-- end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true
	},
	{
		"hrsh7th/cmp-path",
		lazy = true
	},
	{
		"hrsh7th/cmp-buffer",
		lazy = true
	},
	--- FILE SYSTEM ---
	-- Neo Tree -> https://github.com/nvim-neo-tree/neo-tree.nvim
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		window = {
			position = "right",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-tree/nvim-web-devicons", lazy = true }, -- not strictly required, but recommended
			"MunifTanjim/nui.nvim"
		}
	},
	-- Oil -> https://github.com/stevearc/oil.nvim
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
	--- GIT ---
	-- Neogit -> https://github.com/NeogitOrg/neogit
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",         -- required
	-- 		"sindrets/diffview.nvim",        -- optional - Diff integration
	-- 		"nvim-telescope/telescope.nvim", -- optional
	-- 	},
	-- 	config = true
	-- },
	-- Gitsigns -> https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim"
	},
	--- HASKELL ---
	{
		'mrcjkb/haskell-tools.nvim',
		version = '^4', -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	--- INTEGRATION ---
	-- Obsidian -> https://github.com/epwalsh/obsidian.nvim
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		event = {
			-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
			"BufReadPre " .. vim.fn.expand "~" .. "/Documents/Obsidian/**.md",
			"BufNewFile " .. vim.fn.expand "~" .. "/Documents/Obsidian/**.md",
		},
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter"
		},
		opts = {
			workspaces = {
				{
					name = "ams",
					path = "~/Documents/Obsidian/ams"
				},
				{
					name = "mind map",
					path = "~/Documents/Obsidian/Mindmap"
				},
				{
					name = "notes",
					path = "~/Documents/Obsidian/Notes"
				}
			}
		}
	},
	-- {
	-- 	"oflisback/obsidian-bridge.nvim",
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-lua/plenary.nvim"
	-- 	},
	-- 	config = function() require("obsidian-bridge").setup({
	-- 		obsidian_server_address = "https://localhost:27124"
	-- 	}) end,
	-- 	event = {
	-- 		"BufReadPre *.md",
	-- 		"BufNewFile *.md",
	-- 	},
	-- 	lazy = true
	-- },
	--- LATEX ---
	-- VimTeX -> https://github.com/lervag/vimtex
	{
		"lervag/vimtex",
		lazy = false     -- we don't want to lazy load VimTeX
	},
	--- PREVIEW ---
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	lazy = false,      -- Recommended
	-- 	-- ft = "markdown" -- If you decide to lazy-load anyway
	--
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons"
	-- 	}
	-- },
	--- File types ---
	-- Pkl -> https://github.com/apple/pkl-neovim
	{
		"apple/pkl-neovim",
		lazy = true,
		event = {
			"BufReadPre *.pkl",
			"BufReadPre *.pcf",
			"BufReadPre PklProject",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		build = function()
			vim.cmd("TSInstall! pkl")
		end
	},
	-- Markdown Preview -> https://github.com/iamcco/markdown-preview.nvim
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{
				"<leader>m",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			}
		},
		config = function()
			vim.cmd([[do FileType]])
		end
	},
	-- Markdown to PDF -> https://github.com/arminveres/md-pdf.nvim
	{
		'arminveres/md-pdf.nvim',
		branch = 'main', -- you can assume that main is somewhat stable until releases will be made
		lazy = true,
		keys = {
			{
				"<leader>,",
				function()
					require("md-pdf").convert_md_to_pdf()
				end,
				desc = "Markdown preview",
			},
		},
		opts = {}
	},
	-- Vim Table Mode -> https://github.com/dhruvasagar/vim-table-mode
	{
		"dhruvasagar/vim-table-mode"
	},
	--- LSP ---
	-- Mason
	{
		"williamboman/mason.nvim", --> https://github.com/williamboman/mason.nvim
		"williamboman/mason-lspconfig.nvim" --> https://github.com/williamboman/mason-lspconfig.nvim
	},
	-- NVIM LSPconfig -> https://github.com/neovim/nvim-lspconfig
	{
		"neovim/nvim-lspconfig"
	},
	-- LTEX Extra -> https://github.com/barreiroleo/ltex_extra.nvim
	{
		"barreiroleo/ltex-extra.nvim"
	},
	--- iOS DEVELOPMENT ---
	-- XcodeBuild -> https://github.com/wojciech-kulik/xcodebuild.nvim
	-- {
	-- 	"wojciech-kulik/xcodebuild.nvim",
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-tree/nvim-tree.lua", -- (optional) to manage project files
	-- 		"stevearc/oil.nvim", -- (optional) to manage project files
	-- 		"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
	-- 	},
	-- 	config = function()
	-- 		require("xcodebuild").setup({
	-- 			-- put some options here or leave it empty to use default settings
	-- 		})
	-- 	end
	-- }
})

