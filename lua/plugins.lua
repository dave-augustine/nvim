-- ,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,
-- |1/2| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | + | ' | <-    |
-- |---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|
-- | ->| | Q | W | E | R | T | Y | U | I | O | P | ] | ^ |     |
-- |-----',--',--',--',--',--',--',--',--',--',--',--',--'|    |
-- | Caps | A | S | D | F | G | H | J | K | L | \ | [ | * |    |
-- |----,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'---'----|
-- |    | < | Z | X | C | V | B | N | M | , | . | - |          |
-- |----'-,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|
-- | ctrl |  | alt |                          |altgr |  | ctrl |
-- '------'  '-----'--------------------------'------'  '------'
--  ____   ____ ____  _____ _____ ________ ___ _       _   ___     _____ __  __
-- / ___| / ___|  _ \| ____| ____|__  /_ _|_ _( )___  | \ | \ \   / /_ _|  \/  |
-- \___ \| |   | |_) |  _| |  _|   / / | | | ||// __| |  \| |\ \ / / | || |\/| |
--  ___) | |___|  _ <| |___| |___ / /_ | | | |  \__ \ | |\  | \ V /  | || |  | |
-- |____/ \____|_| \_\_____|_____/____|___|___| |___/ |_| \_|  \_/  |___|_|  |_|

--- Author: @dave-augustine

--- @diagnostic disable: missing-parameter, cast-local-type, param-type-mismatch, undefined-field, deprecated
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"goolord/alpha-nvim", -- Dashboard
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				[[                                                                       ]],
				[[  ██████   █████                   █████   █████  ███                  ]],
				[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
				[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
				[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
				[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
				[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
				[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
				[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
				[[                                                                       ]],
				[[                              Screezii                                ]]
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", "󰈞  Find file",
					":Telescope find_files hidden=true no_ignore=true<CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
				dashboard.button("u", "  Update plugins", ":Lazy sync<CR>"),
				dashboard.button("r", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("l", "  Open last session", "<cmd>RestoreSession<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>")
			}

			local handle, err = io.popen("fortune -s")
			if err or handle == nil then
				dashboard.section.footer.val = "Have Fun"
				alpha.setup(dashboard.opts)
				return
			end
			local fortune = handle:read("*a")
			handle:close()
			dashboard.section.footer.val = fortune
			alpha.setup(dashboard.opts)
		end
	},
	{ "sirver/ultisnips" },
	{ "junegunn/goyo.vim" },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" } },
	{
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		config = function()
			require("telescope").load_extension("frecency")
		end
	},
	{ "neoclide/coc.nvim",     branch = "release", build = ":CocUpdate" },
	{ "stevearc/dressing.nvim" },
	{ "honza/vim-snippets" },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				palette_overrides = { dark0_hard = "#0E1018" },
				overrides = {
					Comment = { fg = "#81878f", italic = true, bold = true },
					Define = { link = "GruvboxPurple" },
					Macro = { link = "GruvboxPurple" },
					["@constant.builtin"] = { link = "GruvboxPurple" },
					["@storageclass.lifetime"] = { link = "GruvboxAqua" },
					["@text.note"] = { link = "TODO" },
					["@namespace.latex"] = { link = "Include" },
					["@namespace.rust"] = { link = "Include" },
					ContextVt = { fg = "#878788" },
					CopilotSuggestion = { fg = "#878787" },
					CocCodeLens = { fg = "#878787" },
					CocWarningFloat = { fg = "#dfaf87" },
					CocInlayHint = { fg = "#ABB0B6" },
					CocPumShortcut = { fg = "#fe8019" },
					CocPumDetail = { fg = "#fe8019" },
					DiagnosticVirtualTextWarn = { fg = "#dfaf87" },
					-- fold colors
					Folded = { fg = "#fe8019", bg = "#3c3836", italic = true },
					FoldColumn = { fg = "#fe8019", bg = "#0E1018" },
					SignColumn = { bg = "#fe8019" },
					-- git colors
					DiffAdd = { bold = true, reverse = false, fg = "", bg = "#2a4333" },
					DiffChange = { bold = true, reverse = false, fg = "", bg = "#333841" },
					DiffDelete = { bold = true, reverse = false, fg = "#442d30", bg = "#442d30" },
					DiffText = { bold = true, reverse = false, fg = "", bg = "#213352" },
					-- statusline
					StatusLine = { bg = "#ffffff", fg = "#0E1018" },
					StatusLineNC = { bg = "#3c3836", fg = "#0E1018" },
					CursorLineNr = { fg = "#fabd2f", bg = "" },
					GruvboxOrangeSign = { fg = "#dfaf87", bg = "" },
					GruvboxAquaSign = { fg = "#8EC07C", bg = "" },
					GruvboxGreenSign = { fg = "#b8bb26", bg = "" },
					GruvboxRedSign = { fg = "#fb4934", bg = "" },
					GruvboxBlueSign = { fg = "#83a598", bg = "" },
					WilderMenu = { fg = "#ebdbb2", bg = "" },
					WilderAccent = { fg = "#f4468f", bg = "" },
					-- coc semantic token
					CocSemStruct = { link = "GruvboxYellow" },
					CocSemKeyword = { fg = "", bg = "#0E1018" },
					CocSemEnumMember = { fg = "", bg = "#0E1018" },
					CocSemTypeParameter = { fg = "", bg = "#0E1018" },
					CocSemComment = { fg = "", bg = "#0E1018" },
					CocSemMacro = { fg = "", bg = "#0E1018" },
					CocSemVariable = { fg = "", bg = "#0E1018" },
				}
			})
			vim.cmd.colorscheme("gruvbox")
		end
	},
	{ "numToStr/Comment.nvim" },
	{ "nvim-treesitter/nvim-treesitter",             build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-treesitter/playground",                  lazy = true,                                        cmd = "TSPlaygroundToggle" },
	{ "danymat/neogen",                              config = function() require("neogen").setup({}) end },
	{
		"haringsrob/nvim_context_vt",
		config = function()
			require("nvim_context_vt").setup({
				disable_ft = { "rust", "rs" },
				disable_virtual_lines = true,
				min_rows = 8
			})
		end
	},
	{ "kevinhwang91/nvim-bqf" },
	{ "sbdchd/neoformat" },
	{ "mbbill/undotree",      lazy = true, cmd = "UndotreeToggle" },
	{ "monaqa/dial.nvim" },
	{
		"smjonas/live-command.nvim",
		config = function()
			require("live-command").setup({ commands = { Norm = { cmd = "norm" } } })
		end
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents" },
				auto_session_use_git_branch = true,
				auto_save_enabled = true
			})
		end
	},
	{ "nmac427/guess-indent.nvim", config = function() require("guess-indent").setup({}) end },
	{ "tpope/vim-repeat" },
	{ "kylechui/nvim-surround",    config = function() require("nvim-surround").setup({}) end },
	{ "mhinz/vim-grepper" },
	{ "gelguy/wilder.nvim",        build = ":UpdateRemotePlugins" },
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signcolumn = false,
				status_formatter = function(status)
					local added, changed, removed = status.added, status.changed, status.removed
					local status_txt = {}
					if added and added > 0 then
						table.insert(status_txt, "+" .. added)
					end
					if changed and changed > 0 then
						table.insert(status_txt, "~" .. changed)
					end
					if removed and removed > 0 then
						table.insert(status_txt, "-" .. removed)
					end

					if #status_txt > 1 then
						for i = 2, #status_txt do
							status_txt[i] = "," .. status_txt[i]
						end
					end

					if #status_txt > 2 then
						return string.format("[%s]", table.concat(status_txt))
					else
						return ""
					end
				end
			})
		end
	},
	{ "windwp/nvim-autopairs" },
	{ "uga-rosa/ccc.nvim" },
	{ "wellle/targets.vim" },
	{
		"edluffy/hologram.nvim",
		lazy = true,
		config = function()
			require("hologram").setup({ auto_display = true })
		end
	},
	{ "lervag/vimtex" },
	{ "akinsho/toggleterm.nvim" },
	{ "puremourning/vimspector" }
}, {
	performance = {
		rtp = {
			disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zip Plugin" }
		}
	},
	install = { colorscheme = { "gruvbox" } }
})
