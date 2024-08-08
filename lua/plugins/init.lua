-- ,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,
-- |1/2| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | + | ' | <-    |
-- |---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|
-- | ->| | Q | W | E | R | T | Y | U | I | O | P | ] | ^ |     |
-- |-----',--',--',--',--',--',--',--',--',--',--',--',--'|    |
-- | Caps | A | S | D | F | G | H | J | K | L | \ | [ | * |    |
-- |----,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'---'----|
-- |    | < | Z | X | C | V | B | N | M | , | . | - |          |
-- |----'-,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|
-- | ctrl |  | alt |                          |altgr |  | ctrl | '------'  '-----'--------------------------'------'  '------' ____   ____ ____  _____ _____ ________ ___ _       _   ___     _____ __  __
-- / ___| / ___|  _ \| ____| ____|__  /_ _|_ _( )___  | \ | \ \   / /_ _|  \/  |
-- \___ \| |   | |_) |  _| |  _|   / / | | | ||// __| |  \| |\ \ / / | || |\/| |
--  ___) | |___|  _ <| |___| |___ / /_ | | | |  \__ \ | |\  | \ V /  | || |  | |
-- |____/ \____|_| \_\_____|_____/____|___|___| |___/ |_| \_|  \_/  |___|_|  |_|

--- Author: @dave-augustine

local plugins = {
    require("plugins.goolord"),
    require("plugins.no-setup"),
    require("plugins.solarized"),
    require("plugins.windline"),
    require("plugins.catppuccin"),
    -- require("plugins.neorg"),
    require("plugins.dial"),
    require("plugins.nvim-tree"),
    require("plugins.telescope"),
    require("plugins.coc"),
    require("plugins.auto-session"),
    require("plugins.ccc"),
    require("plugins.comment"),
    require("plugins.dressing"),
    require("plugins.toggleterm"),
    require("plugins.gitsigns"),
    require("plugins.guess-indent"),
    require("plugins.hologram"),
    require("plugins.live-command"),
    require("plugins.mason"),
    require("plugins.neogen"),
    require("plugins.nvim-surround"),
    require("plugins.nvim-autopairs"),
    require("plugins.nvim-treesitter"),
    require("plugins.nvim_context_vt"),
    require("plugins.undotreetoggle"),
    require("plugins.wilder"),
}

return plugins
