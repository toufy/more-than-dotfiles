require('gitsigns').setup {
	signs = {
		add          = { text = '│' },
		change       = { text = '┆' },
		delete       = { text = '-' },
		topdelete    = { text = '-' },
		changedelete = { text = '~' },
		untracked    = { text = '?'},
	},
	signcolumn = true,
	numhl      = false,
	linehl     = false,
	word_diff  = false,
	watch_gitdir = {
		follow_files = true
	},
	attach_to_untracked = true,
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol',
		delay = 100,
		ignore_whitespace = false,
		virt_text_priority = 6,
	},
	current_line_blame_formatter = " <author> <author_mail>, <author_time:%R>"..
	" (on <author_time:%a %d - %b, %Y> at <author_time:%X>)",
	sign_priority = 6,
	update_debounce = 50,
	status_formatter = nil,
	max_file_length = 40000,
	preview_config = {
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	yadm = {
		enable = false
	},
}
