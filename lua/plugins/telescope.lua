return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
        config = function()
            local actions = require("telescope.actions")
            local previewers = require("telescope.previewers")
            local Job = require("plenary.job")

            local _bad = { ".*%.csv", ".*%.lua" } -- Put all filetypes that slow you down in this array
            local bad_files = function(filepath)
                for _, v in ipairs(_bad) do
                    if filepath:match(v) then return false end
                end
                return true
            end

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
        end
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        config = function()
            require("telescope").load_extension("frecency")
        end
    },
}
