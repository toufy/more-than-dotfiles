require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local keymaps = require("keymaps.completions")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	formatting = {
		fields = { "abbr", "kind" },
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},

	mapping = keymaps,

	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	}),

	window = {
		documentation = cmp.config.window.bordered(),
	},
})
