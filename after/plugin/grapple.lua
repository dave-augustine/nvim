local grapple = require("grapple")

-- Global scope keybindings
vim.keymap.set("n", "<localleader>gm", function()
	grapple.tag({ scope = "global" })
end, { desc = "Grapple Global: Add current file to marks" })

vim.keymap.set("n", "<C-g>e", function()
	grapple.toggle_tags({ scope = "global" })
end, { desc = "Grapple Global: Toggle quick menu" })

vim.keymap.set("n", "<C-g>y", function()
	grapple.select({ scope = "global", index = 1 })
end, { desc = "Grapple Global: Navigate to file 1" })

-- Project scope keybindings (git_branch scope)
vim.keymap.set("n", "<localleader>m", function()
	grapple.tag()
end, { desc = "Grapple Project: Add current file to marks" })

vim.keymap.set("n", "<C-e>", function()
	grapple.toggle_tags()
end, { desc = "Grapple Project: Toggle quick menu" })

vim.keymap.set("n", "<C-y>", function()
	grapple.select({ index = 1 })
end, { desc = "Grapple Project: Navigate to file 1" })

vim.keymap.set("n", "<C-t>", function()
	grapple.select({ index = 2 })
end, { desc = "Grapple Project: Navigate to file 2" })

vim.keymap.set("n", "<C-n>", function()
	grapple.select({ index = 3 })
end, { desc = "Grapple Project: Navigate to file 3" })

vim.keymap.set("n", "<C-s>", function()
	grapple.select({ index = 4 })
end, { desc = "Grapple Project: Navigate to file 4" })
