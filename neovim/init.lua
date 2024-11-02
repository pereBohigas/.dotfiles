require("keymaps") -- Make sure to set `mapleader` before lazy so your mappings are correct
require("plugins")
require("disable_netrw")

vim.api.nvim_set_option("clipboard","unnamedplus")

local runtime_path = vim.api.nvim_list_runtime_paths()[1]

vim.cmd("source " .. runtime_path .. "/vimrc")
-- print(runtime_path)

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

-- Add line wrap on vim diff
-- from: https://stackoverflow.com/a/17329864
vim.api.nvim_create_autocmd(
	"FilterWritePre",
	{ pattern = "*", command = "if &diff | setlocal wrap< | endif" }
)

-- Set patterns for OpenAPI configuration files
vim.filetype.add {
	pattern = {
		[".*openapi.*%.ya?ml"] = "yaml.openapi",
		[".*openapi.*%.json"] = "json.openapi",
	}
}

-- Activate conceallevel for Markdown files
vim.api.nvim_create_autocmd(
	"BufEnter",
	{
		pattern = { "*.md" },
		callback = function()
			vim.opt.conceallevel = 1
		end
	}
)

-- Set patterns for gitconfig files
vim.filetype.add {
	pattern = {
		[".*/git/.*config.*"] = "gitconfig"
	}
}

-- Attach language server for GitLab CI files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gitlab-ci*.{yml,yaml}*",
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

