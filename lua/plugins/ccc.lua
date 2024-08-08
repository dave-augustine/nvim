return {
    "uga-rosa/ccc.nvim",
    config = function()
        local ccc = require("ccc")
        ccc.setup({
            highlighter = { auto_enable = true },
            pickers = {
                ccc.picker.hex,
                ccc.picker.css_rgb,
                ccc.picker.css_hsl,
                ccc.picker.css_name
            }
        })
    end,
}

