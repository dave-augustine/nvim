-- ,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,
-- |1/2| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | + | ' | <-    |
-- |---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|
-- | ->| | Q | W | E | R | T | Y | U | I | O | P | ] | ^ |     |
-- |-----',--',--',--',--',--',--',--',--',--',--',--',--'|    |
-- | Caps | A | S | D | F | G | H | J | K | L | \ | [ | * |    |
-- |----,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'---'----|
-- |    | < | Z | X | C | V | B | N | M | , | . | - |          |
-- |----'-,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|
-- | ctrl |  | alt |                          |altgr |  | ctrl |
-- '------'  '-----'--------------------------'------'  '------'
--  ____   ____ ____  _____ _____ ________ ___ _       _   ___     _____ __  __  
-- / ___| / ___|  _ \| ____| ____|__  /_ _|_ _( )___  | \ | \ \   / /_ _|  \/  |
-- \___ \| |   | |_) |  _| |  _|   / / | | | ||// __| |  \| |\ \ / / | || |\/| |
--  ___) | |___|  _ <| |___| |___ / /_ | | | |  \__ \ | |\  | \ V /  | || |  | |  
-- |____/ \____|_| \_\_____|_____/____|___|___| |___/ |_| \_|  \_/  |___|_|  |_|

--- Author: @dave-augustine


-- ================= Load Neovim Dependencies =====================

-- Starting Lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Loading Plugins
local function load_plugins()
	local plugins = require("plugins")
	require("lazy").setup(plugins)
end

load_plugins()

-- Setup Lazy.nvim
--- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--- if not vim.loop.fs_stat(lazypath) then
---     vim.fn.system({
---         "git",
---         "clone",
---         "--filter=blob:none",
---         "https://github.com/folke/lazy.nvim.git",
---         "--branch=stable",
---         lazypath,
---     })
--- end
--- vim.opt.rtp:prepend(lazypath)
--- 
--- local plugins = {}
--- 
--- -- Get a list of all files in the plugins directory, except init.lua
--- local plugin_files = vim.fn.globpath(vim.fn.stdpath('config') .. '/lua/plugins', '*.lua', true, true)
--- 
--- for _, plugin_file in ipairs(plugin_files) do
---     local plugin_name = vim.fn.fnamemodify(plugin_file, ':t:r')
---     if plugin_name ~= 'init' then
---         table.insert(plugins, require('plugins.' .. plugin_name))
---     end
--- end
--- 
--- return plugins

-- Load plugins using Lazy.nvim
--- require("lazy").setup()

-- Loading Options
require("options")
require("keymaps")
require("autocmds")
