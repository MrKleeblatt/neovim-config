-- read config files for every language server
-- see ../config/language_servers/* for lsp configurations
local language_servers = {}
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/config/language_servers', [[v:val =~ '\.lua$']])) do
	local server = file:gsub('%.lua$', '')
	table.insert(language_servers, server)
end

return {
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason").setup({ ui = { icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗"
			}}})
			vim.defer_fn(function() print(table.concat(language_servers, ", ")) end, 0)
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = language_servers,
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp", "folke/neodev.nvim" },
		config = function()
			local nvim_lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup_handlers({
				function(server)
					local options = require('config.language_servers.'.. server)
					-- TODO: merge tables instead of replacement
					options.capabilities = capabilities
					nvim_lsp[server].setup(options)
				end,
			})
		end
	},
	{ "mfussenegger/nvim-dap" },
}

