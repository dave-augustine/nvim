local keyset = vim.keymap.set

-- Global Leader
vim.g.mapleader = ","

-- general
keyset("n", "<leader>e", vim.cmd.NvimTreeToggle, { silent = true })
keyset("n", "S", vim.cmd.w, { silent = true })
keyset("n", "Q", vim.cmd.q, { silent = true })
keyset("x", "<leader>y", '"*y :let @+=@*<cr>', { silent = true })
keyset("n", ";", ":", { noremap = true })
keyset("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
keyset("n", "<C-d>", "<C-d>zz")
keyset("n", "<C-u>", "<C-u>zz")
keyset("n", "n", "nzzzv")
keyset("n", "N", "Nzzzv")
keyset("n", "<space>d", vim.diagnostic.open_float, { silent = true })
keyset("", "<leader>4", function()
	require("conform").format({ async = true, lsp_fallback = true })
end)
keyset("n", "<]a>", "<C-a>", { noremap = true, silent = true })
keyset("v", "<]a>", "g<C-a>", { noremap = true, silent = true })
keyset("n", "<leader>sr", ":%s/<C-r><C-w>//g<Left><Left>")

-- snacks
keyset("n", "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, { silent = true })
keyset("n", "<leader>fk", function() Snacks.picker.keymaps() end, { silent = true })
keyset("n", "<leader>fl", function() Snacks.picker.grep() end, { silent = true })
keyset("n", "<leader>fm", function() Snacks.picker.man() end, { silent = true })
keyset("n", "<leader>sm", function() Snacks.picker.marks() end, { silent = true })
keyset("n", "<leader>fh", function() Snacks.picker.help() end, { silent = true })
keyset("n", "<leader>fz", function() Snacks.picker.zoxide() end, { silent = true })
keyset("n", "<leader>fd", function() Snacks.picker.lsp_definitions() end, { silent = true })
keyset("n", "<leader>fi", function() Snacks.picker.lsp_implementations() end, { silent = true })
keyset("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })

-- toggle term
keyset("n", "<space>y", function() Snacks.terminal.toggle() end, { silent = true })

-- undotree
keyset("n", "<leader>u", function() Snacks.picker.undo() end, { silent = true })

-- movement
keyset("v", "J", ":m '>+1<cr>gv=gv", { silent = true })
keyset("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
keyset("n", "<space>h", "<c-w>h")
keyset("n", "<space>j", "<c-w>j")
keyset("n", "<space>k", "<c-w>k")
keyset("n", "<space>l", "<c-w>l")
keyset("n", "<leader>wh", "<c-w>t<c-h>H")
keyset("n", "<leader>wk", "<c-w>t<c-h>K")
keyset("n", "<down>", ":resize -2<cr>", { silent = true })
keyset("n", "<up>", ":resize +2<cr>", { silent = true })
keyset("n", "<right>", ":vertical resize -2<cr>", { silent = true })
keyset("n", "<left>", ":vertical resize +2<cr>", { silent = true })
keyset("n", "j", "(v:count ? 'j' : 'gj')", { expr = true })
keyset("n", "k", "(v:count ? 'k' : 'gk')", { expr = true })

-- Git
keyset("n", "<leader>fg", function() Snacks.picker.git_files() end, { silent = true })
keyset("n", "<leader>gg", function() Snacks.lazygit.open() end, { silent = true })
keyset("n", "<leader>gl", function() Snacks.picker.git_log() end, { silent = true })
keyset("n", "<leader>gL", function() Snacks.picker.git_log_file() end, { silent = true })
keyset("n", "<leader>gs", ":Git status<cr>", { silent = true })
keyset("n", "<leader>ga", ":Git add %:p<cr><cr>", { silent = true })
keyset("n", "<leader>gd", ":Gdiff<cr>", { silent = true })
keyset("n", "<leader>ge", ":Gedit<cr>", { silent = true })
keyset("n", "<leader>gw", ":Gwrite<cr>", { silent = true })
