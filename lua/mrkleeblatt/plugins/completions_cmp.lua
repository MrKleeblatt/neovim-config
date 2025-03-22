-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
local formatting = {
	-- abbr: abbreviation of "word"; when not empty it is used in the menu instead of "word"
	-- menu: extra text for the popup menu, displayed after "word" or "abbr"
	fields = { 'abbr', 'menu' },
	format = function(entry, vim_item)
		vim_item.menu = ({
			nvim_lsp = '[Lsp]',
			luasnip = '[Luasnip]',
			buffer = '[File]',
			path = '[Path]',
		})[entry.source.name]
		return vim_item
	end,
}


local config = function()
	require("luasnip.loaders.from_vscode").lazy_load()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	cmp.setup({
		snippet = {	expand = function(args) luasnip.lsp_expand(args.body) end },
		mapping = cmp.mapping.preset.insert({
			-- Use <C-b/f> to scroll the docs
			['<C-b>'] = cmp.mapping.scroll_docs( -4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			-- Use <C-k/j> to switch in items
			['<C-k>'] = cmp.mapping.select_prev_item(),
			['<C-j>'] = cmp.mapping.select_next_item(),
			-- Use <C-Space> to confirm selection
			-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<C-Space>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if luasnip.expandable() then luasnip.expand()
					else cmp.confirm({ select = false }) end
				else fallback() end
			end, { "i", "s" }),
		}),
		formatting,
		-- Set source precedence
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },    -- For nvim-lsp
			{ name = 'luasnip' },     -- For luasnip user
			{ name = 'buffer' },      -- For buffer word completion
			{ name = 'path' },        -- For path completion
		})
	})
end

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				-- install jsregexp (optional!).
				build = "make install_jsregexp",
			},
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim", -- vs-code like pictograms
		},
		config = config,
	},
}
