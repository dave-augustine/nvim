function ColorCanvas(color)
	if color then
		vim.cmd("colorscheme " .. color)
	end

	local highlight_groups = {
		"Normal", "NormalFloat", "NormalNC",
		"NvimTreeNormal", "NvimTreeNormalNC",
		"StatusLine", "StatusLineNC",
		"SignColumn", "WinSeparator",
		"TelescopeNormal", "TelescopeBorder",
		"TelescopePromptNormal", "TelescopePromptBorder",
		"TelescopeResultsNormal", "TelescopeResultsBorder",
		"TelescopePreviewNormal", "TelescopePreviewBorder",
		"TelescopePromptTitle", "TelescopeResultsTitle", "TelescopePreviewTitle",
		"NoicePopup", "NoicePopupBorder",
		"NoiceCmdlinePopup", "NoiceCmdlinePopupBorder",
		"NoiceConfirm", "NoiceConfirmBorder",
		"NoiceVirtualText", "NoiceMini",
		"FloatBorder", "Pmenu"
	}

	for _, group in ipairs(highlight_groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end

	vim.opt.termguicolors = true
	vim.cmd([[highlight Normal guibg=None ctermbg=None]])

	vim.api.nvim_set_hl(0, "FloatShadow", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatShadowThrough", { bg = "none" })
	vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })


	vim.api.nvim_create_autocmd("ColorScheme", {
		pattern = "*",
		callback = function()
			for _, group in ipairs(highlight_groups) do
				vim.api.nvim_set_hl(0, group, { bg = "none" })
			end
		end,
	})
end

ColorCanvas("nvcode")
