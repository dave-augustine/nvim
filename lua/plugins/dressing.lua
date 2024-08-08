return {
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup({
			event = "VeryLazy"
		})
	end
}
