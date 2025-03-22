return {
	{
		"dstein64/nvim-scrollview",
		event = "VeryLazy",
		opts = {
			current_only = true,
			character = "|",
			winblend = 25,
			winblend_gui = 10,
			base = "right",
			column = 1,
		},
	},
	{
		"karb94/neoscroll.nvim",
		main = "neoscroll",
		opts = {
			mappings = {},
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
			easing_function = "sine",
			pre_hook = nil,
			post_hook = nil,
			performance_mode = false,
		},
		keys = {
			{
				"<C-u>",
				function()
					require("neoscroll").scroll(-vim.wo.scroll, { move_cursor = true, duration = 250 })
				end,
				desc = "scroll up",
			},
			{
				"<C-d>",
				function()
					require("neoscroll").scroll(vim.wo.scroll, { move_cursor = true, duration = 250 })
				end,
				desc = "scroll down",
			},
		},
	}

}
