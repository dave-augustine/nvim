return {
	"edluffy/hologram.nvim",
	lazy = true,
	config = function()
		require("hologram").setup({ auto_display = true })
	end
}
