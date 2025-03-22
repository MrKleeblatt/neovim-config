return {
	{
		'akinsho/bufferline.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup {
				options = {
					separator_style = "padded_slant",
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end
				}
			}
		end
	}
}
