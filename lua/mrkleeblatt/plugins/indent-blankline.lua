return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "VeryLazy" },
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = {
				enabled = true,
				char = "»",
				show_start = false,
				show_end = false,
				highlight = { "Function", "Label" },
				priority = 500,
			},
			indent = {
				highlight = { "IblIndent" },
			},
		},
	}
}
