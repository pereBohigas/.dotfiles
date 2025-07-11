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
	--- Gruvbox Material -> https://github.com/sainnhe/gruvbox-material
    {
      'sainnhe/gruvbox-material',
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.gruvbox_material_enable_italic = true
        vim.cmd.colorscheme('gruvbox-material')
      end
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
	-- Zen Mode -> https://github.com/folke/zen-mode.nvim
	{
		"folke/zen-mode.nvim",
		opts = {
			window = {
				width = 150
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
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
	-- blink.cmp -> https://github.com/Saghen/blink.cmp
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = { 'rafamadriz/friendly-snippets' },

		-- use a release tag to download pre-built binaries
		version = '1.*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = 'default' },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono'
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	},
	-- -- nvim-cmp -> https://github.com/hrsh7th/nvim-cmp
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	version = false,
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-path",
	-- 		"hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-emoji"
	-- 	}
	-- 	-- ---@param opts cmp.ConfigSchema
	-- 	-- opts = function(_, opts)
	-- 	-- 	table.insert(opts, { name = "emoji" })
	-- 	-- end,
	-- },
	-- {
	-- 	"hrsh7th/cmp-nvim-lsp",
	-- 	lazy = true
	-- },
	-- {
	-- 	"hrsh7th/cmp-path",
	-- 	lazy = true
	-- },
	-- {
	-- 	"hrsh7th/cmp-buffer",
	-- 	lazy = true
	-- },
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
		},
		opts = {
			event_handlers = {
				event = "neo_tree_buffer_enter",
				handler = function()
					vim.opt_local.relativenumber = true
				end
			}
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
	-- {
	-- 	"epwalsh/obsidian.nvim",
	-- 	version = "*", -- recommended, use latest release instead of latest commit
	-- 	lazy = true,
	-- 	event = {
	-- 		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	-- 		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	-- 		"BufReadPre " .. vim.fn.expand "~" .. "/Documents/Obsidian/**.md",
	-- 		"BufNewFile " .. vim.fn.expand "~" .. "/Documents/Obsidian/**.md",
	-- 	},
	-- 	dependencies = {
	-- 		-- Required.
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-treesitter/nvim-treesitter"
	-- 	},
	-- 	opts = {
	-- 		workspaces = {
	-- 			{
	-- 				name = "adesso",
	-- 				path = "~/Documents/Obsidian/adesso"
	-- 			},
	-- 			{
	-- 				name = "mind map",
	-- 				path = "~/Documents/Obsidian/Mindmap"
	-- 			},
	-- 			{
	-- 				name = "notes",
	-- 				path = "~/Documents/Obsidian/Notes"
	-- 			}
	-- 		}
	-- 	}
	-- },
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
			--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
			--   -- refer to `:h file-pattern` for more examples
			--   "BufReadPre path/to/my-vault/*.md",
			--   "BufNewFile path/to/my-vault/*.md",
			-- },
			dependencies = {
				-- Required.
				"nvim-lua/plenary.nvim",

				-- see above for full list of optional dependencies ☝️
			},
			---@module 'obsidian'
			---@type obsidian.config.ClientOpts
			opts = {
				workspaces = {
					{
						name = "adesso",
						path = "~/Documents/Obsidian/adesso"
					},
					{
						name = "mind map",
						path = "~/Documents/Obsidian/mind"
					},
					{
						name = "notes",
						path = "~/Documents/Obsidian/notes"
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
	-- Typst Preview -> https://github.com/chomosuke/typst-preview.nvim
	{
		'chomosuke/typst-preview.nvim',
		ft = 'typst',
		version = '1.*',
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	lazy = false,      -- Recommended
	-- 	-- ft = "markdown" -- If you decide to lazy-load anyway
	--
	-- 	dependencies = h{
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
	-- Xcode project files (*.pbxproj) -> https://github.com/cfdrake/vim-pbxproj
	{
		"cfdrake/vim-pbxproj"
	},
	-- Markdown Preview -> https://github.com/toppair/peek.nvim
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	-- Markdown Preview -> https://github.com/iamcco/markdown-preview.nvim
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	ft = { "markdown" },
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	ft = "markdown",
	-- 	build = function()
	-- 		vim.fn["mkdp#util#install"]()
	-- 	end,
	-- 	keys = {
	-- 		{
	-- 			"<leader>m",
	-- 			"<cmd>MarkdownPreviewToggle<cr>",
	-- 			desc = "Markdown Preview",
	-- 		}
	-- 	},
	-- 	-- config = function()
	-- 	-- 	vim.cmd([[do FileType]])
	-- 	-- end
	-- },
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

