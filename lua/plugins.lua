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
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim <CR>"),
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
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/lua-utils.nvim", "pysan3/pathlib.nvim", "nvim-neotest/nvim-nio" },
		config = function()
			require("neorg").setup {
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.summary"] = {},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
				},
			}
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},
	{ "williamboman/mason.nvim" },
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

-- ccc color picker
local ccc = require("ccc")
ccc.setup({
	highlighter = { auto_enable = true },
	pickers = {
		ccc.picker.hex, ccc.picker.css_rgb, ccc.picker.css_hsl,
		ccc.picker.css_name
	}
})

-- wilder
local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option("pipeline", {
	wilder.branch(wilder.python_file_finder_pipeline({
		file_command = function(_, arg)
			if string.find(arg, ".") ~= nil then
				return { "fd", "-tf", "-H" }
			else
				return { "fd", "-tf" }
			end
		end,
		dir_command = { "fd", "-td" },
		filters = { "fuzzy_filter", "difflib_sorter" }
	}), wilder.cmdline_pipeline(), wilder.python_search_pipeline())
})

wilder.set_option("renderer", wilder.popupmenu_renderer({
	highlighter = wilder.basic_highlighter(),
	left = { " " },
	right = { " ", wilder.popupmenu_scrollbar({ thumb_char = " " }) },
	highlights = { default = "WilderMenu", accent = "WilderAccent" }
}))

-- Used in VimTex

function VimtexPDFToggle()
	if vim.g.term_pdf_vierer_open then
		vim.fn.system("kitty @ close-window --match title:termpdf")
		vim.g.term_pdf_vierer_open = false
	elseif vim.g.tex_compiles_successfully then
		vim.fn.system("kitty @ launch --location=vsplit --cwd=current --title=termpdf")

		local command = "termpdf.py " .. vim.api.nvim_call_function("expand", { "%:r" }) .. ".pdf" .. "'\r'"
		local kitty = "kitty @ send-text --match title:termpdf "
		vim.fn.system(kitty .. command)
		vim.g.term_pdf_vierer_open = true
	end
end

-- toggleterm
require("toggleterm").setup({
	shade_terminals = false,
	shell = vim.fn.trim(vim.fn.system('which $SHELL')),
	highlights = {
		StatusLine = { guifg = "#ffffff", guibg = "#0E1018" },
		StatusLineNC = { guifg = "#ffffff", guibg = "#0E1018" }
	}
})


local Terminal = require("toggleterm.terminal").Terminal

local lg_cmd = "lazygit -w $PWD"
if vim.v.servername ~= nil then
	lg_cmd = string.format(
		"NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml -w $PWD",
		vim.v.servername)
end

vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"

local lazygit = Terminal:new({
	cmd = lg_cmd,
	count = 5,
	direction = "float",
	float_opts = {
		border = "double",
		width = function() return vim.o.columns end,
		height = function() return vim.o.lines end
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
			{ noremap = true, silent = true })
	end
})

function Edit(fn, line_number)
	local edit_cmd = string.format(":e %s", fn)
	if line_number ~= nil then
		edit_cmd = string.format(":e +%d %s", line_number, fn)
	end
	vim.cmd(edit_cmd)
end

function Lazygit_toggle() lazygit:toggle() end

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt" },
	map_cr = false,
	disable_in_visualblock = true,
	check_ts = true
})

local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
local autopairs = require("nvim-autopairs")

autopairs.add_rules({
	rule("$", "$", { "tex", "latex", "neorg" }):with_cr(cond.none())
})

autopairs.get_rule("`").not_filetypes = { "tex", "latex" }
autopairs.get_rule("'")[1].not_filetypes = { "tex", "latex", "rust" }

require("dressing").setup({
	event = "VeryLazy"
})

require("Comment").setup({
	pre_hook = function()
		return
				require("ts_context_commentstring.internal").calculate_commentstring()
	end
})

local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local _bad = { ".*%.csv", ".*%.lua" } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
	for _, v in ipairs(_bad) do if filepath:match(v) then return false end end
	return true
end

---@diagnostic disable-next-line: redefined-local
local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}
	if opts.use_ft_detect == nil then opts.use_ft_detect = true end
	opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
	filepath = vim.fn.expand(filepath)

	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then return end
		if stat.size > 100000 then return end
	end)

	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				-- maybe we want to write something to the buffer here
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				end)
			end
		end
	}):sync()
end

require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		buffer_previewer_maker = new_maker,
		layout_config = { prompt_position = "bottom" },
		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<C-q>"] = actions.send_to_qflist,
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-d>"] = actions.delete_buffer + actions.move_to_top
			}
		}
	},
	pickers = {
		find_files = { theme = "ivy", layout_config = { height = 0.4 } },
		git_files = { theme = "ivy", layout_config = { height = 0.4 } },
		live_grep = { theme = "ivy", layout_config = { height = 0.4 } },
		buffers = { theme = "ivy", layout_config = { height = 0.4 } },
		keymaps = { theme = "ivy", layout_config = { height = 0.4 } },
		file_browser = { theme = "ivy", layout_config = { height = 0.4 } },
		treesitter = { theme = "ivy", layout_config = { height = 0.4 } },
		help_tags = { theme = "ivy", layout_config = { height = 0.5 } },
		man_pages = {
			sections = { "1", "2", "3" },
			theme = "ivy",
			layout_config = { height = 0.4 }
		}
	}
})

local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.constant.alias.bool, augend.integer.alias.decimal,
		augend.integer.alias.hex, augend.constant.new({
		elements = { "and", "or" },
		word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
		cyclic = true -- "or" is incremented into "and".
	}),
		augend.constant
				.new({ elements = { "&&", "||" }, word = false, cyclic = true })
	}
})

-- Skip loading the deprecated module
vim.g.skip_ts_context_commentstring_module = true


require("nvim-treesitter.configs").setup({
	highlight = { enable = true, additional_vim_regex_highlighting = { "latex" } },
	playground = {
		enable = true,
		updatetime = 25,      -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false -- Whether the query persists across vim sessions
	},
	indent = { enable = true, disable = { "python" } },
	textobjects = {
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
				["]s"] = {
					query = "@scope",
					query_group = "locals",
					desc = "Next scope"
				}
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer"
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer"
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer"
			},
			goto_next = { ["]d"] = "@conditional.outer" },
			goto_previous = { ["[d"] = "@conditional.outer" }
		},
		swap = {
			enable = true,
			swap_next = { ["<leader>a"] = "@parameter.inner" },
			swap_previous = { ["<leader>A"] = "@parameter.inner" }
		},
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner"
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>" -- blockwise
			}
		}
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<space>i",
			scope_incremental = "<space>i",
			node_incremental = "<space>n",
			node_decremental = "<space>p"
		}
	}
})

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})
