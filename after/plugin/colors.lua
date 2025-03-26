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
		"FloatBorder", "FloatShadow", "FloatShadowThrough", "Pmenu" }

	local diagnostic_groups = {
		"DiagnosticVirtualTextError", "DiagnosticVirtualTextWarn",
		"DiagnosticVirtualTextInfo", "DiagnosticVirtualTextHint", "DiagnosticVirtualTextOk"
	}

	for _, group in ipairs(diagnostic_groups) do
		vim.cmd("highlight " .. group .. " guibg=NONE")
	end

	for _, group in ipairs(highlight_groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end


	vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
end

ColorCanvas("rose-pine")
