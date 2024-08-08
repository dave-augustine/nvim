return {
	"windwp/nvim-autopairs",
	config = function()
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
	end
}
