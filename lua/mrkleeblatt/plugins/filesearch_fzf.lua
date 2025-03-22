local register_autodeletion = function ()
	vim.api.nvim_create_autocmd("BufNew",{ callback = function ()
		local buffers = vim.api.nvim_list_bufs()
		for _, buffer in ipairs(buffers) do
			local bufname = vim.api.nvim_buf_get_name(buffer)
			if vim.fn.isdirectory(bufname) == 1 then vim.api.nvim_buf_delete(buffer, {force = true}) end
		end
	end })
end

return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			triggers = {
				{ "<leader>", mode = { "n", "v" } },
			}
		},
		config = function ()
			if vim.fn.argc() ~= 0 then
				local first_file = vim.fn.argv(0)
				assert(type(first_file) == "string", "file not a string but a "..type(first_file))
				-- if directory opened
				if vim.fn.isdirectory(first_file) == 1 then vim.fn.chdir(first_file) end
			end
			register_autodeletion()
		end,
		keys = {
			{
				"<leader>?",
				function() require("which-key").show({ global = false }) end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	}
}
