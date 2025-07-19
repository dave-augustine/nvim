return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- dependencies = {
		-- 	"nvim-treesitter/nvim-treesitter-context"
		-- },
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "java", "go", "python", "javascript", "typescript" },
				auto_install = true,
				sync_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "latex" }
				},
				indent = { enable = true },
			})
		end
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = {
					{ "rafamadriz/friendly-snippets" },
					{ "honza/vim-snippets" },
					{ "molleweide/LuaSnip-snippets.nvim" },
				},
				config = function()
					local ls = require("luasnip")

					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_snipmate").lazy_load()
					require("luasnip.loaders.from_lua").lazy_load()

					vim.keymap.set({ "i" }, "<C-L>", function()
						ls.expand()
					end, { silent = true })
					vim.keymap.set({ "i", "s" }, "<C-J>", function()
						ls.jump(1)
					end, { silent = true })
					vim.keymap.set({ "i", "s" }, "<C-K>", function()
						ls.jump(-1)
					end, { silent = true })

					vim.keymap.set({ "i", "s" }, "<C-E>", function()
						if ls.choice_active() then
							ls.change_choice(1)
						end
					end, { silent = true })
				end,
			},
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				},
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete({ silent = true }),
					["<C-u>"] = cmp.mapping.scroll_docs(-4, { silent = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-d>"] = cmp.mapping.scroll_docs(4, { silent = true }),
					["<Tab>"] = cmp.mapping.select_next_item({ silent = true }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ silent = true }),
				}),
				snippet = {
					expand = function(args)
						-- vim.snippet.expand(args.body)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				}
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lsp_defaults = require("lspconfig").util.default_config
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lsp_defaults.capabilities =
					vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					local function goto_definition_vsplit()
						-- Save the current window
						local current_win = vim.api.nvim_get_current_win()
						-- Open a vertical split
						vim.cmd('vsplit')
						-- Get the new window
						local new_win = vim.api.nvim_get_current_win()
						-- Perform the LSP go-to-definition
						vim.lsp.buf.definition()
						-- Ensure focus stays in the new window (optional)
						vim.api.nvim_set_current_win(new_win)
					end

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set('n', 'gvd', goto_definition_vsplit,
						{ noremap = true, silent = true, desc = 'Go to definition in vertical split' })
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
					vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set("n", "<space>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})

			require("mason-lspconfig").setup({
				-- Disable for NixOS
				automatic_installation = true,
				ensure_installed = {},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
				},
			})

			require("lspconfig").eslint.setup({
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				settings = {
					workingDirectory = { mode = "auto" },
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true
			}
		},
	},
}
