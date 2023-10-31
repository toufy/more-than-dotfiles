require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		java = { "google-java-format" },
		html = { "prettier" },
		css = { "prettier" },
		javascript = { "prettier" },
		json = { "prettier" },
	},
	formatters = {
		clang_format = {
			prepend_args = { "--style=Microsoft", "--sort-includes" },
		},
		stylua = {
			prepend_args = { "--column-width", "100" },
		},
		prettier = {
			prepend_args = {
				"--print-width",
				"100",
				"--tab-width",
				"4",
				"--use-tabs",
				"--prose-wrap",
				"always",
				"--html-whitespace-sensitivity",
				"strict",
				"--single-attribute-per-line",
			},
		},
	},
	format_on_save = {
		lsp_fallback = false,
		timeout_ms = 500,
	},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
})
