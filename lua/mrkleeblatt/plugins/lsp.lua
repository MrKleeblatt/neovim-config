local setup_mason = function()
	require("mason").setup { ui = { icons = {
		package_installed = "✓",
		package_pending = "➜",
		package_uninstalled = "✗"
	} } }
end


local setup_mason_lspconfig = function()
	require("mason-lspconfig").setup {
		automatic_installation = true,
		ensure_installed = {
			"jsonls",
			"clangd",
			"dockerls",
			"denols",
			"gopls",
			"lua_ls",
			"marksman",
			"yamlls",
			"rust_analyzer",
		},
	}
end

local setup_lspconfig = function()
	local lsp = require("lspconfig")
	local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
	require("mason-lspconfig").setup_handlers {
		function(server)
			lsp[server].setup {
				capabilities = default_capabilities,
				inlayHints = { enable = true },
			}
		end,
	}
end

return {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"nvimtools/none-ls.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"folke/neodev.nvim",
			{
				"LhKipp/nvim-nu",
				build = ":TSInstall nu",
			}
		},
		config = function()
			setup_mason()
			setup_mason_lspconfig()
			setup_lspconfig()
			require("mrkleeblatt.lsp.nulsp")
			require("mrkleeblatt.lsp.clangd")
		end
	}
}
