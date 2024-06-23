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


-- ccc color picker
local ccc = require("ccc")
ccc.setup({
    highlighter = { auto_enable = true },
    pickers = {
        ccc.picker.hex, ccc.picker.css_rgb, ccc.picker.css_hsl,
        ccc.picker.css_name
    }
})

-- wilder
local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option("pipeline", {
    wilder.branch(wilder.python_file_finder_pipeline({
        file_command = function(_, arg)
            if string.find(arg, ".") ~= nil then
                return { "fd", "-tf", "-H" }
            else
                return { "fd", "-tf" }
            end
        end,
        dir_command = { "fd", "-td" },
        filters = { "fuzzy_filter", "difflib_sorter" }
    }), wilder.cmdline_pipeline(), wilder.python_search_pipeline())
})

wilder.set_option("renderer", wilder.popupmenu_renderer({
    highlighter = wilder.basic_highlighter(),
    left = { " " },
    right = { " ", wilder.popupmenu_scrollbar({ thumb_char = " " }) },
    highlights = { default = "WilderMenu", accent = "WilderAccent" }
}))

-- autocmds
local autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_augroup("Random", { clear = true })

autocmd("User", {
    group = "Random",
    pattern = "AlphaReady",
    callback = function()
        vim.opt.cmdheight = 0
        vim.opt.laststatus = 0
        vim.wo.fillchars = "eob: "

        autocmd("BufUnload", {
            pattern = "<buffer>",
            callback = function()
                vim.opt.cmdheight = 1
                vim.opt.laststatus = 3
                vim.wo.fillchars = "eob:~"
            end
        })
    end,
    desc = "Disable Bufferline in Alpha"
})

autocmd("VimResized", {
    group = "Random",
    desc = "Keep windows equally resized",
    command = "tabdo wincmd ="
})

autocmd("TermOpen", {
    group = "Random",
    command = "setlocal nonumber norelativenumber signcolumn=no"
})

autocmd("InsertEnter", { group = "Random", command = "set timeoutlen=100" })
autocmd("InsertLeave", { group = "Random", command = "set timeoutlen=1000" })

--- coc auto commands
vim.api.nvim_create_augroup("CocGroup", {})

autocmd("User", {
    group = "CocGroup",
    pattern = "CocLocationsChange",
    desc = "Update location list on locations change",
    callback = function()
        local locs = vim.g.coc_jump_locations
        vim.fn.setloclist(0, {}, " ", { title = "CocLocationList", items = locs })
        local winid = vim.fn.getloclist(0, { winid = 0 }).winid
        if winid == 0 then
            vim.cmd("bel lw")
        else
            vim.api.nvim_set_current_win(winid)
        end
    end,
})

autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- vimtex
vim.g.tex_compiles_successfully = false
vim.g.term_pdf_vierer_open = false

vim.api.nvim_create_augroup("CustomTex", {})
autocmd("User", {
    group = "CustomTex",
    pattern = "VimtexEventCompileSuccess",
    callback = function()
        vim.g.tex_compiles_successfully = true

        -- a hacky way to reload the pdf in the terminal
        -- when it has changed
        if vim.g.term_pdf_vierer_open and vim.g.tex_compiles_successfully then
            local command = "termpdf.py " .. vim.api.nvim_call_function("expand", { "%:r" }) .. ".pdf" .. "'\r'"
            local kitty = "kitty @ send-text --match title:termpdf "
            vim.fn.system(kitty .. command)
        end
    end,
})

autocmd("User", {
    group = "CustomTex",
    pattern = "VimtexEventCompileFailed",
    callback = function()
        vim.g.tex_compiles_successfully = false
    end,
})

autocmd("User", {
    group = "CustomTex",
    pattern = "VimtexEventQuit",
    callback = function()
        vim.fn.system("kitty @ close-window --match title:termpdf")
    end,
})

function VimtexPDFToggle()
    if vim.g.term_pdf_vierer_open then
        vim.fn.system("kitty @ close-window --match title:termpdf")
        vim.g.term_pdf_vierer_open = false
    elseif vim.g.tex_compiles_successfully then
        vim.fn.system("kitty @ launch --location=vsplit --cwd=current --title=termpdf")

        local command = "termpdf.py " .. vim.api.nvim_call_function("expand", { "%:r" }) .. ".pdf" .. "'\r'"
        local kitty = "kitty @ send-text --match title:termpdf "
        vim.fn.system(kitty .. command)
        vim.g.term_pdf_vierer_open = true
    end
end

-- toggleterm
require("toggleterm").setup({
    shade_terminals = false,
    shell = vim.fn.trim(vim.fn.system('which fish')),
    highlights = {
        StatusLine = { guifg = "#ffffff", guibg = "#0E1018" },
        StatusLineNC = { guifg = "#ffffff", guibg = "#0E1018" }
    }
})


local Terminal = require("toggleterm.terminal").Terminal

local lg_cmd = "lazygit -w $PWD"
if vim.v.servername ~= nil then
    lg_cmd = string.format(
        "NVIM_SERVER=%s lazygit -ucf ~/.config/nvim/lazygit.toml -w $PWD",
        vim.v.servername)
end

vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"

local lazygit = Terminal:new({
    cmd = lg_cmd,
    count = 5,
    direction = "float",
    float_opts = {
        border = "double",
        width = function() return vim.o.columns end,
        height = function() return vim.o.lines end
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
            { noremap = true, silent = true })
    end
})

function Edit(fn, line_number)
    local edit_cmd = string.format(":e %s", fn)
    if line_number ~= nil then
        edit_cmd = string.format(":e +%d %s", line_number, fn)
    end
    vim.cmd(edit_cmd)
end

function Lazygit_toggle() lazygit:toggle() end

require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt" },
    map_cr = false,
    disable_in_visualblock = true,
    check_ts = true
})

local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
local autopairs = require("nvim-autopairs")

autopairs.add_rules({
    rule("$", "$", { "tex", "latex", "neorg" }):with_cr(cond.none())
})

autopairs.get_rule("`").not_filetypes = { "tex", "latex" }
autopairs.get_rule("'")[1].not_filetypes = { "tex", "latex", "rust" }

require("dressing").setup({
    event = "VeryLazy"
})

require("Comment").setup({
    pre_hook = function()
        return
            require("ts_context_commentstring.internal").calculate_commentstring()
    end
})

local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local _bad = { ".*%.csv", ".*%.lua" } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
    for _, v in ipairs(_bad) do if filepath:match(v) then return false end end
    return true
end

---@diagnostic disable-next-line: redefined-local
local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then opts.use_ft_detect = true end
    opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
    filepath = vim.fn.expand(filepath)

    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then return end
    end)

    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                end)
            end
        end
    }):sync()
end

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        buffer_previewer_maker = new_maker,
        layout_config = { prompt_position = "bottom" },
        mappings = {
            i = {
                ["<Esc>"] = actions.close,
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-d>"] = actions.delete_buffer + actions.move_to_top
            }
        }
    },
    pickers = {
        find_files = { theme = "ivy", layout_config = { height = 0.4 } },
        git_files = { theme = "ivy", layout_config = { height = 0.4 } },
        live_grep = { theme = "ivy", layout_config = { height = 0.4 } },
        buffers = { theme = "ivy", layout_config = { height = 0.4 } },
        keymaps = { theme = "ivy", layout_config = { height = 0.4 } },
        file_browser = { theme = "ivy", layout_config = { height = 0.4 } },
        treesitter = { theme = "ivy", layout_config = { height = 0.4 } },
        help_tags = { theme = "ivy", layout_config = { height = 0.5 } },
        man_pages = {
            sections = { "1", "2", "3" },
            theme = "ivy",
            layout_config = { height = 0.4 }
        }
    }
})

local augend = require("dial.augend")
require("dial.config").augends:register_group({
    default = {
        augend.constant.alias.bool, augend.integer.alias.decimal,
        augend.integer.alias.hex, augend.constant.new({
        elements = { "and", "or" },
        word = true,      -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
        cyclic = true     -- "or" is incremented into "and".
    }),
        augend.constant
            .new({ elements = { "&&", "||" }, word = false, cyclic = true })
    }
})

-- Skip loading the deprecated module
vim.g.skip_ts_context_commentstring_module = true


require("nvim-treesitter.configs").setup({
    highlight = { enable = true, additional_vim_regex_highlighting = { "latex" } },
    playground = {
        enable = true,
        updatetime = 25,        -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    indent = { enable = true, disable = { "python" } },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = { query = "@class.outer", desc = "Next class start" },
                ["]s"] = {
                    query = "@scope",
                    query_group = "locals",
                    desc = "Next scope"
                }
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            },
            goto_next = { ["]d"] = "@conditional.outer" },
            goto_previous = { ["[d"] = "@conditional.outer" }
        },
        swap = {
            enable = true,
            swap_next = { ["<leader>a"] = "@parameter.inner" },
            swap_previous = { ["<leader>A"] = "@parameter.inner" }
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            },
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V",  -- linewise
                ["@class.outer"] = "<c-v>"  -- blockwise
            }
        }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<space>i",
            scope_incremental = "<space>i",
            node_incremental = "<space>n",
            node_decremental = "<space>p"
        }
    }
})
