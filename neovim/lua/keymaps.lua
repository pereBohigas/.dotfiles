vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Moving
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", ":m .+1<CR>==")
vim.keymap.set("n", "K", ":m .-2<CR>==")

-- Buffers
vim.api.nvim_set_keymap("n", "tk", ":blast<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "tj", ":bfirst<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "th", ":bprev<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "tl", ":bnext<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", { noremap = false })

-- Scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy & Paste
vim.keymap.set("x", "<leader>p", "\"_dP")

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Markdown Preview
vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreview<CR>")

-- netrw is not being used (because of nvim-tree), hence re-implement gx to open links in browser
vim.keymap.set("n", "gx", '<Cmd>call jobstart(["open", expand("<cfile>")], { "detach": v:true })<CR>')

