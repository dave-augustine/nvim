return {
	{
		"goolord/alpha-nvim",
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
				dashboard.button("f", "󰈞  Find file", function() Snacks.picker.smart() end),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim <CR>"),
				dashboard.button("u", "  Update plugins", ":Lazy sync<CR>"),
				dashboard.button("r", "  Recently opened files", function() Snacks.picker.recent() end),
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
	{
		"theprimeagen/harpoon",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "<c-/>", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},
	{
		"folke/todo-comments.nvim",
		opts = {},
		keys = {
			{ "]t",              function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
			{ "[t",              function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
			{ "<localleader>st", function() Snacks.picker.todo_comments() end,        desc = "Todo Picker" }
		},
	},
	{
		"MagicDuck/grug-far.nvim",
		event = "VeryLazy",
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sR",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
	},
	{ "tpope/vim-fugitive" },
	{ "djoshea/vim-autoread" },
	{ "wellle/targets.vim" },
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup({
				map_cr = false,
				disable_in_visualblock = true,
				check_ts = true
			})
		end
	},
	{ "tpope/vim-surround" },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},
			})
		end
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		config = function()
			require("trouble").setup({})
		end,
		keys = {
			{
				"<localleader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
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
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				git = {
					ignore = false
				},
				sort = {
					sorter = "case_sensitive",
				},
				disable_netrw = true,
				view = {
					width = 50,
				},
				update_focused_file = {
					enable = true,
					update_root = false
				},
				actions = {
					open_file = {
						quit_on_open = true
					}
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
				},
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")

					local function map(mode, key, action, desc)
						vim.keymap.set(mode, key, action,
							{ desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true })
					end

					api.config.mappings.default_on_attach(bufnr)

					map("n", "l", api.node.open.edit, "Open File/Directory")
					map("n", "h", api.node.navigate.parent_close, "Close Directory")
					map("n", "?", api.tree.toggle_help, "Toggle Help") -- Example additional binding
				end,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring"
		},
		config = function()
			require("Comment").setup {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end
	},
	{
		"haringsrob/nvim_context_vt",
		event = "VeryLazy",
		config = function()
			require("nvim_context_vt").setup({
				disable_ft = { "rust", "rs" },
				disable_virtual_lines = true,
				min_rows = 8
			})
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'auto',
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = true,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					}
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'filename' },
					lualine_x = { 'encoding', 'fileformat', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' }
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {}
			}
		end
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			lazygit = {},
			terminal = {},
			picker = {},
		}
	},
	{
		"lervag/vimtex",
		init = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_compiler_latexmk_engines = { ["_"] = "-lualatex -shell-escape" }
			vim.g.vimtex_indent_on_ampersands = 0
			vim.g.matchup_override_vimtex = 1
		end
	}
}
