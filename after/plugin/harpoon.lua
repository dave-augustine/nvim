local harpoon = require("harpoon")

vim.keymap.set("n", "<localleader>gm", function() harpoon:list("global"):add() end,
	{ desc = "Harpoon Global: Add current file to marks" })
vim.keymap.set("n", "<C-g>e", function() harpoon.ui:toggle_quick_menu(harpoon:list("global")) end,
	{ desc = "Harpoon Global: Toggle quick menu" })
vim.keymap.set("n", "<C-g>y", function() harpoon:list("global"):select(1) end,
	{ desc = "Harpoon Global: Navigate to file 1" })

vim.keymap.set("n", "<localleader>m", function() harpoon:list("project"):add() end,
	{ desc = "Harpoon Project: Add current file to marks" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list("project")) end,
	{ desc = "Harpoon Project: Toggle quick menu" })
vim.keymap.set("n", "<C-y>", function() harpoon:list("project"):select(1) end,
	{ desc = "Harpoon Project: Navigate to file 1" })
vim.keymap.set("n", "<C-t>", function() harpoon:list("project"):select(2) end,
	{ desc = "Harpoon Project: Navigate to file 2" })
vim.keymap.set("n", "<C-n>", function() harpoon:list("project"):select(3) end,
	{ desc = "Harpoon Project: Navigate to file 3" })
vim.keymap.set("n", "<C-s>", function() harpoon:list("project"):select(4) end,
	{ desc = "Harpoon Project: Navigate to file 4" })
