local cmp = require("cmp")

return {
	["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
	["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	["<C-y>"] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	}),
	["<C-e>"] = cmp.mapping({
		i = cmp.mapping.abort(),
		c = cmp.mapping.close(),
	}),
}
