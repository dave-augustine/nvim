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

-- telescope
-- keyset("n", "<leader>ff", ":Telescope frecency workspace=CWD theme=ivy layout_config={height=0.4}<cr>")
keyset("n", "<leader>ff", ":Telescope find_files<cr>", { silent = true })
keyset("n", "<leader>fk", ":Telescope keymaps<cr>", { silent = true })
keyset("n", "<leader>fl", ":Telescope live_grep<cr>", { silent = true })
keyset("n", "<leader>fg", ":Telescoope git_files<cr>", { silent = true })
keyset("n", "<leader>fs", ':GrepperRg "" .<Left><Left><Left>')
keyset("n", "<leader>fS", ":Rg<space>")
keyset("n", "<leader>sr", ":%s/<C-r><C-w>//g<Left><Left>")


-- toggle term
keyset("n", "<space>y", ":ToggleTerm size=15<cr>", { silent = true })
keyset("n", "<space>t", ":ToggleTerm size=60 direction=vertical<cr>", { silent = true })
keyset("n", "<space><space>", ":ToggleTerm size=60 direction=float<cr>", { silent = true })
keyset("n", "<localleader>1", ":ToggleTerm 1 size=60 direction=float<cr>", { silent = true })
keyset("n", "<localleader>2", ":ToggleTerm 2 size=60 direction=float<cr>", { silent = true })



-- undotree
keyset("n", "<leader>u", ":UndotreeToggle<cr>", { silent = true })

-- movement
keyset("v", "J", ":m '>+1<cr>gv=gv")
keyset("v", "K", ":m '<-2<cr>gv=gv")
keyset("n", "<space>h", "<c-w>h")
keyset("n", "<space>j", "<c-w>j")
keyset("n", "<space>k", "<c-w>k")
keyset("n", "<space>l", "<c-w>l")
keyset("n", "<leader>wh", "<c-w>t<c-h>H")
keyset("n", "<leader>wk", "<c-w>t<c-h>K")
keyset("n", "<down>", ":resize +2<cr>")
keyset("n", "<up>", ":resize -2<cr>")
keyset("n", "<right>", ":vertical resize +2<cr>")
keyset("n", "<left>", ":vertical resize -2<cr>")
keyset("n", "j", "(v:count ? 'j' : 'gj')", { expr = true })
keyset("n", "k", "(v:count ? 'k' : 'gk')", { expr = true })

-- fugitive
keyset("n", "<leader>gg", ":Git<cr>", { silent = true })
keyset("n", "<leader>gs", ":Git status<cr>", { silent = true })
keyset("n", "<leader>ga", ":Git add %:p<cr><cr>", { silent = true })
keyset("n", "<leader>gd", ":Gdiff<cr>", { silent = true })
keyset("n", "<leader>ge", ":Gedit<cr>", { silent = true })
keyset("n", "<leader>gw", ":Gwrite<cr>", { silent = true })
keyset("n", "<leader>gf", ":Commits<cr>", { silent = true })
