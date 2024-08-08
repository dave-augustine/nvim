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

-- =================== Leader Key ===============================
vim.g.mapleader = ","

-- =================== Global Options ===========================
-- ### General Settings
vim.opt.termguicolors = true      -- Enables 24-bit RGB color in the TUI
vim.opt.clipboard = "unnamedplus" -- Uses the system clipboard for copy/paste
vim.opt.shell = "$(which $SHELL)" -- Sets the default shell to bash
vim.opt.mouse = "a"               -- Enables mouse support
vim.opt.scrolloff = 8             -- Keeps 8 lines visible above and below the cursor
vim.opt.conceallevel = 2          -- Controls the conceal feature for syntax elements
vim.opt.shortmess:append("c")     -- Avoids showing completion messages
vim.opt.showmode = false          -- Hides the mode display (e.g., -- INSERT --)
vim.opt.laststatus = 3            -- Always shows the status line with global status
vim.opt.backup = false            -- Disables creating backup files
vim.opt.writebackup = false       -- Disables writing backup files
vim.opt.updatetime = 300          -- Specifies the time (in milliseconds) to wait for writing changes to disk
vim.opt.signcolumn = "number"     -- Shows sign column along with line numbers

-- ### Display Settings
vim.opt.number = true -- Shows line numbers
vim.opt.relativenumber = true -- Shows relative line numbers
vim.opt.cursorline = true -- Highlights the line with the cursor
vim.opt.cursorlineopt = "number" -- Highlights the line number in the cursorline
vim.opt.colorcolumn = "9999999" -- Highlights column at 90 characters
vim.opt.breakindent = true -- Maintains indentation for wrapped lines
vim.opt.breakindentopt = { shift = 2 } -- Sets shift for break indent
vim.opt.showbreak = "↳" -- Character to show at the start of wrapped lines

-- Vimtex config
vim.g.skip_ts_context_commentstring_module = true
vim.g.tex_flavor = "latex"
vim.g.tex_conceal = "abdmgs"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk_engines = { ["_"] = "-lualatex" }
vim.g.vimtex_view_enabled = 0
vim.g.vimtex_view_automatic = 0
vim.g.vimtex_indent_on_ampersands = 0

-- ### Other Settings
vim.g.python3_host_prog = vim.fn.trim(vim.fn.system('which python3'))
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28
vim.g.netrw_browsex_viewer = "open -a brave"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.termdebug_popup = 0
vim.g.termdebug_wide = 163
vim.g.vimspector_install_gadgets = { "debugpy", "vscode-cpptools", "CodeLLDB" }
vim.g.neoformat_try_formatprg = 1
vim.g.latexindent_opt = "-m"
vim.g.coc_enable_locationlist = 0
vim.g.coc_global_extensions = {
    "coc-rust-analyzer",
    "coc-clangd",
    "coc-prettier",
    "coc-tsserver",
    "coc-sumneko-lua",
    "coc-json",
    "coc-texlab",
    "coc-pyright",
}


-- ### Search Settings
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true  -- Case sensitive if uppercase is used

-- ### Indentation Settings
vim.opt.expandtab = false -- Uses tabs instead of spaces
vim.opt.tabstop = 2       -- Sets tab width to 2 spaces
vim.opt.shiftwidth = 2    -- Sets indentation width to 2 spaces
vim.opt.softtabstop = 2   -- Sets number of spaces per tab in insert mode
vim.opt.autoindent = true -- Automatically indent new lines


-- ### File Management
vim.opt.undofile = true -- Enables persistent undo

-- ### Split Window Settings
vim.opt.splitbelow = true -- Opens horizontal splits below
vim.opt.splitright = true -- Opens vertical splits to the right

-- ### Performance Settings
vim.opt.lazyredraw = true -- Redraws only when necessary

-- ### Completion Settings
vim.opt.completeopt = { "longest", "noinsert", "menuone", "noselect", "preview" } -- Configures completion options

-- ### Custom Functions
function SpellToggle()
    if vim.opt.spell:get() then
        vim.opt_local.spell = false
        vim.opt_local.spelllang = "en"
    else
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { "en_us" }
    end
end

local git_branch = function()
    if vim.g.loaded_fugitive then
        local branch = vim.fn.FugitiveHead()
        if branch ~= "" then
            if vim.api.nvim_win_get_width(0) <= 80 then
                return " " .. string.upper(branch:sub(1, 2))
            end
            return " " .. string.upper(branch)
        end
    end
    return ""
end

local human_file_size = function()
    local format_file_size = function(file)
        local size = vim.fn.getfsize(file)
        if size <= 0 then return "" end
        local sufixes = { "B", "KB", "MB", "GB" }
        local i = 1
        while size > 1024 do
            size = size / 1024
            i = i + 1
        end
        return string.format("[%.0f%s]", size, sufixes[i])
    end

    local file = vim.api.nvim_buf_get_name(0)
    if string.len(file) == 0 then return "" end
    return format_file_size(file)
end

local smart_file_path = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name == "" then return "[No Name]" end
    local home = vim.env.HOME
    local is_term = false
    local file_dir = ""

    if buf_name:sub(1, 5):find("term") ~= nil then
        ---@type string
        file_dir = vim.env.PWD
        if file_dir == home then return "$HOME " end
        is_term = true
    else
        file_dir = vim.fs.dirname(buf_name)
    end

    file_dir = file_dir:gsub(home, "~", 1)

    if vim.api.nvim_win_get_width(0) <= 80 then
        file_dir = vim.fn.pathshorten(file_dir)
    end

    if is_term then
        return file_dir .. " "
    else
        return string.format("%s/%s ", file_dir, vim.fs.basename(buf_name))
    end
end

local word_count = function()
    local words = vim.fn.wordcount()
    if words.visual_words ~= nil then
        return string.format("[%s]", words.visual_words)
    else
        return string.format("[%s]", words.words)
    end
end

local modes = setmetatable({
    ["n"] = { "NORMAL", "N" },
    ["no"] = { "N·OPERATOR", "N·P" },
    ["v"] = { "VISUAL", "V" },
    ["V"] = { "V·LINE", "V·L" },
    [""] = { "V·BLOCK", "V·B" },
    [""] = { "V·BLOCK", "V·B" },
    ["s"] = { "SELECT", "S" },
    ["S"] = { "S·LINE", "S·L" },
    [""] = { "S·BLOCK", "S·B" },
    ["i"] = { "INSERT", "I" },
    ["ic"] = { "INSERT", "I" },
    ["R"] = { "REPLACE", "R" },
    ["Rv"] = { "V·REPLACE", "V·R" },
    ["c"] = { "COMMAND", "C" },
    ["cv"] = { "VIM·EX", "V·E" },
    ["ce"] = { "EX", "E" },
    ["r"] = { "PROMPT", "P" },
    ["rm"] = { "MORE", "M" },
    ["r?"] = { "CONFIRM", "C" },
    ["!"] = { "SHELL", "S" },
    ["t"] = { "TERMINAL", "T" }
}, {
    __index = function()
        return { "UNKNOWN", "U" } -- handle edge cases
    end
})

local get_current_mode = function()
    local mode = modes[vim.api.nvim_get_mode().mode]
    if vim.api.nvim_win_get_width(0) <= 80 then
        return string.format("%s ", mode[2]) -- short name
    else
        return string.format("%s ", mode[1]) -- long name
    end
end

function status_line()
    return table.concat({
        get_current_mode(),                      -- Get current mode
        "%{toupper(&spelllang)}",                -- Display language and if spell is on
        git_branch(),                            -- Branch name
        " %<",                                   -- Spacing
        smart_file_path(),                       -- Smart full path filename
        "%h%m%r%w",                              -- Help flag, modified, readonly, and preview
        "%=",                                    -- Right align
        "%{get(b:,'gitsigns_status','')}",       -- Git signs
        word_count(),                            -- Word count
        "[%-3.(%l|%c]",                          -- Line number, column number
        human_file_size(),                       -- File size
        "[%{strlen(&ft)?&ft[0].&ft[1:]:'None'}]" -- File type
    })
end

-- vim.opt.statusline = "%!luaeval('status_line()')"
-- vim.cmd.colorscheme("catppuccin-mocha")
