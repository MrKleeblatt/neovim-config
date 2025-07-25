return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"jsonls",
				"clangd", -- C and C++
				"dockerls",
				"denols",
				"gopls",
				"lua_ls",
				"yamlls",
				"markdown_oxide",
				"tinymist",
			}
		},
		-- config = function()
		-- 	local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- 	default_capabilities.offsetEncoding = { "utf-8", "utf-16" }
		-- end

	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local configs = require('lspconfig.configs')
			if not configs.c3_lsp then
				configs.c3_lsp = {
					default_config = {
						cmd = {
							"/usr/bin/c3lsp"
						},
						filetypes = { "c3", "c3i" },
						root_dir = function()
							-- Try project.json
							local pr_json = vim.fs.root(0, "project.json")
							if pr_json ~= nil then
								return pr_json
							end
							-- Try git root
							local git_root = vim.fs.root(0, ".git")
							if git_root ~= nil then
								return git_root
							end
							-- Nothing found, assume standalone C3 file
							return vim.fn.getcwd()
						end,
						settings = {
							["diagnostic-delay"] = 5,
						},
						name = "c3_lsp"
					}
				}
			end
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.c3_lsp.setup {}
			lspconfig.hls.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.markdown_oxide.setup({ capabilities = capabilities })
			lspconfig.pylsp.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })
		end,
	},
	-- non-lsp tools into the LSP experience (diagnostic, formatting, etc.)
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function(_, opts)
			opts.sources = { require("null-ls").builtins.formatting.clang_format }
			opts.offsetEncoding = { "utf-8", "utf-16" }
		end
	},
	-- code completions
	"hrsh7th/cmp-nvim-lsp",
	-- semantic in neovim config
	"folke/neodev.nvim",
	-- nushell syntax highlighting
	{
		"LhKipp/nvim-nu",
		build = ":TSInstall nu",
	}

}
