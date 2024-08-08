return {
	"monaqa/dial.nvim",
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.constant.alias.bool, augend.integer.alias.decimal,
				augend.integer.alias.hex, augend.constant.new({
				elements = { "and", "or" },
				word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
				cyclic = true -- "or" is incremented into "and".
			}),
				augend.constant
						.new({ elements = { "&&", "||" }, word = false, cyclic = true })
			}
		})
	end
}
