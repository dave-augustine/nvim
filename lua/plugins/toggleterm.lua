return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            shade_terminals = false,
            shell = vim.trim(vim.fn.system("which $SHELL")),
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
    end
}
