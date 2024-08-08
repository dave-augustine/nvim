return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            shade_terminals = false,
            shell = vim.fn.trim(vim.fn.system('which $SHELL')),
            highlights = {
                StatusLine = { guifg = "#ffffff", guibg = "#0E1018" },
                StatusLineNC = { guifg = "#ffffff", guibg = "#0E1018" }
            }
        })

        local Terminal = require("toggleterm.terminal").Terminal

        local lg_cmd = "lazygit -w $PWD"
        if vim.v.servername and vim.v.servername ~= "" then
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
                width = function() return math.floor(vim.o.columns * 0.8) end, -- Adjust width to avoid overflow
                height = function() return math.floor(vim.o.lines * 0.8) end   -- Adjust height to avoid overflow
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                    { noremap = true, silent = true })
            end
        })

        function Lazygit_toggle() lazygit:toggle() end
    end
}
