-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP Actions',
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		-- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		-- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>c', vim.lsp.buf.code_action, opts)
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		-- vim.keymap.set('n', '<leader>f', function()
		-- 	vim.lsp.buf.format { async = true }
		-- end, opts)
	end
})

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"ltex",
		"vacuum"
	}
})

-- Suppress warning "undefined global `vim`" on Neovim files
require('lspconfig').lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'}
			}
		}
	}
}

require("lspconfig").ltex.setup {
	on_attach = function(client, bufnr)
		-- rest of your on_attach process.
		require("ltex_extra").setup { }
	end,
	settings = {
		ltex = {
			language = "en-US",
		},
		additionalRules = {
			enablePickyRules = true,
			motherTongue = "ca-ES",
		},
		sign_column = true
	}
}

require("lspconfig").vacuum.setup {}

require("lspconfig").ruby_lsp.setup {}

require("lspconfig").taplo.setup {}

require("lspconfig").gitlab_ci_ls.setup {}

-- from: https://chrishannah.me/using-a-swift-lsp-in-neovim
-- xcrun --toolchain swift sourcekit-lsp --help
-- xcrun --find sourcekit-lsp
-- TOOLCHAIN_PATH = /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp

-- local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })
--  vim.api.nvim_create_autocmd("FileType", {
--  	pattern = { "swift" },
--  	callback = function()
--  		local root_dir = vim.fs.dirname(vim.fs.find({
--  			"Package.swift",
--  			".git",
--  		}, { upward = true })[1])
--  		local client = vim.lsp.start({
--  			name = "sourcekit-lsp",
--  			cmd = { "sourcekit-lsp" },
--  			root_dir = root_dir,
--  		})
--  		vim.lsp.buf_attach_client(0, client)
--  	end,
--  	group = swift_lsp
--  })

require("lspconfig").sourceKit.setup {
	-- cmd = {'/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp'},
	capabilities = {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true
			}
		}
	}
}

