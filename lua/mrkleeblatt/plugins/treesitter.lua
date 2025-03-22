return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "VeryLazy" },
		opts = {
			ensure_installed = {
				"bash", "c", "css", "go", "html", "javascript", "json", "lua", "markdown",
				"markdown_inline", "python", "rust", "toml", "typescript", "typst"
			}
		},
		config = function()
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false
		end
	}
}
