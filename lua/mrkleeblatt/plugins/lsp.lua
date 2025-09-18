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
				"html",
				"gopls",
				"lua_ls",
				"yamlls",
				"markdown_oxide",
				"tinymist",
				"zls",
			}
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("c3_lsp", {
				default_config = {
					cmd = { "/usr/bin/c3lsp" },
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
					capabilities = capabilities,
				}
			})


			vim.lsp.config("clangd", { capabilities = capabilities })
			vim.lsp.enable({ "clangd", "c3_lsp" })
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
	},
	{
		'nvim-flutter/flutter-tools.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
		config = true,
	},
}
