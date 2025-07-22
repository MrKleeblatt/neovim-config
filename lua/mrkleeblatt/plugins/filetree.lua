function NvimTreeTrash()
	local lib = require('nvim-tree.lib')
	local node = lib.get_node_at_cursor()
	local trash_cmd = "trash "

	local function get_user_input_char()
		local c = vim.fn.getchar()
		return vim.fn.nr2char(c)
	end

	print("Trash " .. node.name .. " ? y/n")

	if (get_user_input_char():match('^y') and node) then
		vim.fn.jobstart(trash_cmd .. node.absolute_path, {
			detach = true,
			on_exit = function(job_id, data, event) lib.refresh_tree() end,
		})
	end

	vim.api.nvim_command('normal :esc<CR>')
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		keys = {
			{
				"<leader>fe",
				function()
					local api = require("nvim-tree.api")
					api.tree.open()
				end,
				desc = "Open file tree",
			}
		},
		config = function()
			local nvim_tree = require "nvim-tree"
			nvim_tree.setup({
				git = { enable = false },
				trash = { cmd = "trash" },
				on_attach = function(bufnr)
					local api = require "nvim-tree.api"
					api.config.mappings.default_on_attach(bufnr)
					vim.keymap.del("n", "<C-E>", { buffer = bufnr })
					vim.keymap.set("n", "d", api.fs.trash,
						{ desc = "nvim-tree: Trash", buffer = bufnr, noremap = true, silent = true, nowait = true })
				end
			})
		end,
	}
}
