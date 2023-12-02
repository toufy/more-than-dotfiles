require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = false,
	no_italic = false,
	no_bold = false,
	no_underline = false,
	custom_highlights = function(colors)
		return {
			CursorLine = { bg = colors.surface0, blend = 10 },
			CursorColumn = { bg = colors.surface0, blend = 10 },
		}
	end,
	integrations = {
		cmp = true,
		gitsigns = true,
		treesitter = true,
		harpoon = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		telescope = {
			enabled = true,
		},
		mason = true,
	},
})

vim.cmd.colorscheme("catppuccin")
