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

-- ==================== Key Remapping =========================
local keyset = vim.keymap.set

-- ===================== Dial =================================
keyset("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
keyset("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
keyset("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
keyset("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
keyset("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
keyset("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })

-- remap to include undo and more things
keyset("i", ",", ",<C-g>U")
keyset("i", ".", ".<C-g>U")
keyset("i", "!", "!<C-g>U")
keyset("i", "?", "?<C-g>U")
keyset("x", ".", ":norm.<cr>")
keyset("x", "<leader>y", '"*y :let @+=@*<cr>')
keyset("n", "<a-x>", "<nop>")
keyset("n", "<backspace>", "<C-^")
keyset("n", "cp", "yap<S-}p")
keyset("n", ";", ":", { noremap = true })
keyset("n", "Q", ":q<cr>")
keyset("n", "S", ":w<cr>")


-- general
keyset("n", "<space>y", ":ToggleTerm size=15<cr>", { silent = true })
keyset("n", "<space>t", ":ToggleTerm size=60 direction=vertical<cr>", { silent = true })
keyset("n", "<space><space>", ":ToggleTerm size=60 direction=float<cr>", { silent = true })
keyset("n", "<leader>t", ":NvimTreeFocus<cr>", { silent = true })
keyset("n", "<leader>u", ":UndotreeToggle<cr>", { silent = true })
keyset("n", "<leader>e", ":NvimTreeToggle<cr>", { silent = true })
keyset("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
keyset("n", "<leader>cc", ":bdelete<cr>")
keyset("n", "<leader>cn", ":cnext<cr>")
keyset("n", "<leader>cp", ":cprevious<cr>")
keyset("n", "<leader>P", '"+gP')
keyset("n", "<leader>p", '"+gp')
keyset("n", "<leader>sf", ":source %<cr>")
keyset("n", "<leader>z", "[s1z=``")
keyset("n", "<leader>1", ":bp<cr>")
keyset("n", "<leader>2", ":bn<cr>")
keyset("n", "<leader>3", ":retab<cr>:FixWhitespace<cr>")
keyset("n", "<leader>4", ":Format<cr>")
keyset("n", "<leader>5", ":lua SpellToggle()<cr>")
keyset("n", "<leader>sr", ":%s/<<C-r><C-w>>//g<Left><Left>")
keyset("n", "<leader>q", ":wq<cr>")
keyset("n", "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>", { silent = true })
keyset("n", "<leader>gy", ":Goyo<cr>")

-- Movement
keyset("v", "J", ":m '>+1<cr>gv=gv")
keyset("v", "K", ":m '<-2<cr>gv=gv")
keyset("n", "<space>h", "<c-w>h")
keyset("n", "<space>j", "<c-w>j")
keyset("n", "<space>k", "<c-w>k")
keyset("n", "<space>l", "<c-w>l")
keyset("n", "<leader>wh", "<c-w>t<c-h>H")
keyset("n", "<leader>wk", "<c-w>t<c-h>K")
keyset("n", "<down>", ":resize +2<cr>")
keyset("n", "<up>", ":resize -2<cr>")
keyset("n", "<right>", ":vertical resize +2<cr>")
keyset("n", "<left>", ":vertical resize -2<cr>")
keyset("n", "j", "(v:count ? 'j' : 'gj')", { expr = true })
keyset("n", "k", "(v:count ? 'k' : 'gk')", { expr = true })

-- Telescope + grepper
keyset("n", "<leader><leader>f", ":Telescope git_files<cr>")
keyset("n", "<leader>fl", ":Telescope live_grep<cr>")
keyset("n", "<leader>ff", ":Telescope frecency workspace=CWD theme=ivy layout_config={height=0.4}<cr>")
keyset("n", "<leader>fb", ":Telescope buffers<cr>")
keyset("n", "<leader>fr", ":Telescope registers<cr>")
keyset("n", "<leader>fm", ":Telescope man_pages<cr>")
keyset("n", "<leader>ft", ":Telescope treesitter<cr>")
keyset("n", "<leader>fk", ":Telescope keymaps<cr>")
keyset("n", "<leader>fh", ":Telescope help_tags<cr>")
keyset("n", "<leader>fs", ':GrepperRg "" .<Left><Left><Left>')
keyset("n", "<leader>fS", ":Rg<space>")
keyset("n", "<leader>*", ":Grepper -tool rg -cword -noprompt<cr>")
keyset("n", "gs", "<Plug>(GrepperOperator)")
keyset("x", "gs", "<Plug>(GrepperOperator)")

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

keyset({ "n", "x", "o" }, "-", ts_repeat_move.repeat_last_move_next)
keyset({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
keyset({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
keyset({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
keyset({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
keyset({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

-- fugitive
keyset("n", "<leader>gg", ":Git<cr>", { silent = true })
keyset("n", "<leader>ga", ":Git add %:p<cr><cr>", { silent = true })
keyset("n", "<leader>gd", ":Gdiff<cr>", { silent = true })
keyset("n", "<leader>ge", ":Gedit<cr>", { silent = true })
keyset("n", "<leader>gw", ":Gwrite<cr>", { silent = true })
keyset("n", "<leader>gf", ":Commits<cr>", { silent = true })

if vim.fn.has("mac") then
    keyset("n", "<leader>0", ":silent !open -a brave %<cr>")
else
    keyset("n", "<leader>0", ":silent !xdg-open %<cr>")
end

vim.api.nvim_create_user_command("FixWhitespace", [[%s/\s\+$//e]], {})

-- coc

vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

function _G.check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local has_backspace = vim.api.nvim_get_current_line():sub(col, col):match("%s") ~= nil
    return col == 0 or has_backspace
end

function _G.diagnostic()
    vim.fn.CocActionAsync("diagnosticList", "", function(err, res)
        if err == vim.NIL then
            if vim.tbl_isempty(res) then return end
            local items = {}
            for _, d in ipairs(res) do
                local text = ""
                local type = d.severity
                local msg = d.message:match("([^\n]+)\n*")
                local code = d.code
                if code == vim.NIL or code == nil or code == "NIL" then
                    text = ("[%s] %s"):format(type, msg)
                else
                    text = ("[%s|%s] %s"):format(type, code, msg)
                end

                local item = {
                    filename = d.file,
                    lnum = d.lnum,
                    end_lnum = d.end_lnum,
                    col = d.col,
                    end_col = d.end_col,
                    text = text
                }
                table.insert(items, item)
            end
            vim.fn.setqflist({}, " ", { title = "CocDiagnosticList", items = items })
            vim.cmd("bo cope")
        end
    end)
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

-- autocomplete
local opts = { silent = true, noremap = true, expr = true }
vim.api.nvim_set_keymap("i", "<TAB>",
    'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.api.nvim_set_keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
vim.api.nvim_set_keymap("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
    opts)
keyset("n", "<c-j>", "<Plug>(coc-snippets-expand-jump)", { noremap = true, silent = true })
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

vim.cmd [[
    set runtimepath+=~/.vim/my-snippets/
]]

-- scroll through documentation
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true, expr = true }
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- go to definition and other things
keyset("n", "<c-k>", "<Plug>(coc-rename)", { silent = true })
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
keyset("n", "<space>a", "<Plug>(coc-codeaction-cursor)", opts)
keyset("x", "<space>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<space>s", "<Plug>(coc-codeaction-source)", opts)
keyset("n", "<space>x", "<Plug>(coc-codeaction-line)", opts)
keyset("n", "<space>g", "<Plug>(coc-codelens-action)", opts)
keyset("n", "<space>f", "<Plug>(coc-fix-current)", opts)
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
keyset("n", "<space>q", ":<C-u>CocList<cr>", opts)
vim.api.nvim_set_keymap("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

-- ToggleTerm
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

