vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
	-- ### general ### --
	-- packer
	use("wbthomason/packer.nvim")
	-- theme (catppuccin)
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.cmd("colorscheme catppuccin")
		end,
	})
	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	-- indent guides
	use("lukas-reineke/indent-blankline.nvim")

	-- ### misc ### --
	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- treesitter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	-- undotree
	use("mbbill/undotree")
	-- gitsigns
	use("lewis6991/gitsigns.nvim")
	-- harpoon
	use({
		"ThePrimeagen/harpoon",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- ### LSP config ### --
	-- lspconfig with mason
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	-- linting
	use("mfussenegger/nvim-lint")
	-- completions & snippets
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use({
		"L3MON4D3/LuaSnip",
		run = "make install_jsregexp",
		requires = { "rafamadriz/friendly-snippets" },
	})
	use("saadparwaiz1/cmp_luasnip")
	use("onsails/lspkind.nvim")
	-- formatting
	use("mhartington/formatter.nvim")
end)
