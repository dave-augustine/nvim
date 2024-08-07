return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true, additional_vim_regex_highlighting = { "latex" } },
				playground = {
					enable = true,
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
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
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "InsertEnter"
	},
	{
		"nvim-treesitter/playground",
		lazy = true,
		cmd = "TSPlaygroundToggle"
	},
}
