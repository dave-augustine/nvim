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
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
		config = function()
			local actions = require("telescope.actions")
			local previewers = require("telescope.previewers")
			local Job = require("plenary.job")

			local _bad = { ".*%.csv", ".*%.lua" }
			local bad_files = function(filepath)
				for _, v in ipairs(_bad) do
					if filepath:match(v) then return false end
				end
				return true
			end

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
					man_pages = { sections = { "1", "2", "3" }, theme = "ivy", layout_config = { height = 0.4 }
					}
				}
			})
		end
	},
	-- {
	-- TODO: Setup Frecency with my Telescope
	-- 	"nvim-telescope/telescope-frecency.nvim",
	-- 	dependencies = { "kkharji/sqlite.lua" },
	-- 	config = function()
	-- 		require("telescope").load_extension("frecency")
	-- 	end
	-- },
	{
		"theprimeagen/harpoon",
		event = "VeryLazy",
	},
	{
		"mbbill/undotree",
		event = "VeryLazy",
		cmd = "UndotreeToggle"
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
		cmd = { "TodoTrouble", "TodoTelescope" },
		opts = {},
		keys = {
			{ "]t",         function() require("todo-comments").jump_next() end,              desc = "Next Todo Comment" },
			{ "[t",         function() require("todo-comments").jump_prev() end,              desc = "Previous Todo Comment" },
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>",                                   desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>",                                         desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",                 desc = "Todo/Fix/Fixme" },
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
				disable_filetype = { "TelescopePrompt" },
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
					width = 30,
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
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			require("toggleterm").setup({
				shade_terminals = false,
				shell = vim.trim(vim.fn.system("which $SHELL")),
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
		end
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
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
	}
}
