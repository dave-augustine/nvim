return {
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
}
