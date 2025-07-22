return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = 'main',
		lazy = false,
		build = ":TSUpdate",
		opts = {
			highlight = { enable = true, },
			ensure_installed = {
				"bash", "c", "css", "go", "json", "lua", "markdown",
				"markdown_inline", "toml", "typescript", "typst", "nu", "c3",
			}
		},
		config = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false
		end
	}
}
