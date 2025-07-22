return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_installation = true,
			automatic_enable = true,
			ensure_installed = {
				"jsonls",
				"clangd",
				"dockerls",
				"denols",
				"gopls",
				"lua_ls",
				"yamlls",
			},
		},
		config = function()
			local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
			default_capabilities.offsetEncoding = { "utf-8", "utf-16" }
		end

	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local configs = require('lspconfig.configs')
			if not configs.c3_lsp then
				configs.c3_lsp = {
					default_config = {
						cmd = {
							os.getenv("HOME")
							.. "/.local/bin/c3lsp"
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
							["diagnostic-delay"] = 50,
						},
						name = "c3_lsp"
					}
				}
			end
		end
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
