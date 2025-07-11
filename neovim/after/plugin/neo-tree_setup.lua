vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>", { silent = true })

require("neo-tree").setup {
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	filesystem = {
		filtered_items = {
			visible = true -- when true, they will just be displayed differently than normal items
			-- hide_dotfiles = true,
			-- hide_gitignored = true,
			-- hide_hidden = true, -- only works on Windows for hidden files/directories
		},
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- window like netrw would, regardless of window.position
		-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
	},
	close_if_last_window = true,
	default_component_configs = {
		icon = {
			folder_empty = "󰜌",
			folder_empty_open = "󰜌",
		},
		git_status = {
			symbols = {
				renamed   = "󰁕",
				unstaged  = "󰄱",
			},
		},
	},
	document_symbols = {
		kinds = {
			File = { icon = "󰈙", hl = "Tag" },
			Namespace = { icon = "󰌗", hl = "Include" },
			Package = { icon = "󰏖", hl = "Label" },
			Class = { icon = "󰌗", hl = "Include" },
			Property = { icon = "󰆧", hl = "@property" },
			Enum = { icon = "󰒻", hl = "@number" },
			Function = { icon = "󰊕", hl = "Function" },
			String = { icon = "󰀬", hl = "String" },
			Number = { icon = "󰎠", hl = "Number" },
			Array = { icon = "󰅪", hl = "Type" },
			Object = { icon = "󰅩", hl = "Type" },
			Key = { icon = "󰌋", hl = "" },
			Struct = { icon = "󰌗", hl = "Type" },
			Operator = { icon = "󰆕", hl = "Operator" },
			TypeParameter = { icon = "󰊄", hl = "Type" },
			StaticMethod = { icon = '󰠄 ', hl = 'Function' },
		}
	},
	-- use a custom function for sorting files and directories in the tree
	-- sort_function = function (a,b)
	-- 	if a.type == b.type then
	-- 		return a.path > b.path
	-- 	else
	-- 		return a.type > b.type
	-- 	end
	-- end , -- this sorts files and directories descendantly
	-- Add this section only if you've configured source selector.
	source_selector = {
		sources = {
			{ source = "filesystem", display_name = " 󰉓 Files " },
			{ source = "git_status", display_name = " 󰊢 Git " },
		},
	},
	view = { relativenumber = false },
	window = {
		position = "left",
		width = 30,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			-- ["<space>"] = {
			--     "toggle_node",
			--     nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
			-- },
			-- ["<2-LeftMouse>"] = "open",
			-- ["<cr>"] = "open",
			["<leader><leader>"] = "open",
			-- ["<esc>"] = "revert_preview",
			-- ["P"] = { "toggle_preview", config = { use_float = true } },
			["<leader>p"] = { "toggle_preview", config = { use_float = true } },
			-- ["l"] = "focus_preview",
			-- ["S"] = "open_split",
			-- ["l"] = "open_vsplit",
			["l"] = "open_vsplit",
			-- ["S"] = "split_with_window_picker",
			["t"] = "open_tabnew",
			-- ["<cr>"] = "open_drop",
			-- ["t"] = "open_tab_drop",
			-- ["w"] = "open_with_window_picker",
			["w"] = "open_with_window_picker",
			-- ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
			-- ["C"] = "close_node",
			-- ['C'] = 'close_all_subnodes',
			-- ["z"] = "close_all_nodes",
			-- ["Z"] = "expand_all_nodes",
			["o"] = {
				"add",
				-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "none" -- "none", "relative", "absolute"
				}
			},
			["O"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
			["dd"] = "delete",
			["c"] = "rename",
			-- ["y"] = "copy_to_clipboard",
			["yy"] = "copy_to_clipboard",
			-- ["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			-- ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
			-- ["c"] = {
			--     "copy",
			--     config = {
			--         show_path = "none" -- "none", "relative", "absolute"
			--     }
			-- },
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["q"] = "close_window",
			["r"] = "refresh",
			["?"] = "show_help",
			-- ["<"] = "prev_source",
			-- [">"] = "next_source",
		}
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function()
				vim.opt_local.relativenumber = false
				-- vim.opt_local.relativenumber = false
			end
		}
	}
}

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = { require('neo-tree').toggle } })
vim.api.nvim_create_augroup("neotree", {})

vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Open Neotree automatically",
	group = "neotree",
	callback = function()
		vim.cmd "Neotree toggle"
		vim.opt_local.relativenumber = false
		-- vim.cmd "set norelativenumber"
		-- if vim.fn.argc() == 0 and not vim.fn.exists "s:std_in" then
		--     print("here")
		--     vim.cmd "Neotree toggle"
		-- end
	end
})

