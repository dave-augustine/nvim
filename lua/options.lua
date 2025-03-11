vim.opt.termguicolors = true
vim.opt.clipboard = "unnamed"
vim.opt.backup = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.breakindent = true
vim.opt.breakindentopt = { shift = 2 }
vim.opt.showbreak = "↳"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.signcolumn = "no"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.splitbelow = true
vim.opt.splitright = true


