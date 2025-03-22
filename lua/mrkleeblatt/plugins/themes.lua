return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{ "tanvirtin/monokai.nvim",      lazy = false, priority = 1000, },
	{ "projekt0n/github-nvim-theme", lazy = true,  priority = 1000 },
	{ "ellisonleao/gruvbox.nvim",    lazy = true,  priority = 1000 },
	{ "rebelot/kanagawa.nvim",       lazy = true,  priority = 1000 },
	{ "xero/miasma.nvim",            lazy = true,  priority = 1000 },
	{ "EdenEast/nightfox.nvim",      lazy = true,  priority = 1000 },
	{ "folke/tokyonight.nvim",       lazy = true,  priority = 1000 },
}
