local wk = require("which-key")

local function reload()
  dofile(vim.env.MYVIMRC)
  print("Configuration reloaded")
end

-- https://github.com/folke/which-key.nvim
local keymaps = {
	-- remove most unnecessary keybindings
	{ "<Space>", "<Nop>"},
	{ "G", "<Nop>", mode = "n", hidden = true},
	{ "gg", "<Nop>", mode = "n", hidden = true},
	{ "ge", "<Nop>", mode = "n", hidden = true},
	{ "gn", "<Nop>", mode = "n", hidden = true},
	{ "gN", "<Nop>", mode = "n", hidden = true},
	{ "gt", "<Nop>", mode = "n", hidden = true},
	{ "gT", "<Nop>", mode = "n", hidden = true},
	{ "gu", "<Nop>", mode = "n", hidden = true},
	{ "gU", "<Nop>", mode = "n", hidden = true},
	{ "gw", "<Nop>", mode = "n", hidden = true},
	{ "g%", "<Nop>", mode = "n", hidden = true},
	{ "g~", "<Nop>", mode = "n", hidden = true},
	{ "gc", "<Nop>", mode = "n", hidden = true},
	{ "g'", "<Nop>", mode = "n", hidden = true},
	{ "g`", "<Nop>", mode = "n", hidden = true},
	-- GOTO
	{ "g", group = "goto" },
	{ "gD", function() vim.lsp.buf.declaration() end, desc = "declaration" },
	{ "gd", function() vim.lsp.buf.definition() end, desc = "definition" },
	{ "gr", function() vim.lsp.buf.references() end, desc = "references" },
	-- code actions
	{ "<leader>c", group = "code" },
	{ "<leader>ca", vim.lsp.buf.code_action, desc = "actions" },
	{ "<leader>cr", vim.lsp.buf.rename, desc = "rename" },
	{ "<leader>p", "<Nop>", hidden = true },
	{ "<leader>cf", vim.lsp.buf.format, desc = "format with lsp" },
	{ "<leader>cp", ":Prettier<cr>", desc = "format with prettier" },
	-- stay in indent mode
	{ "<", "<gv", mode = "v", desc =  "indent left" },
	{ ">", ">gv", mode = "v", desc = "indent right" },
	-- don't yank on paste
	{ "p", "P", mode = "v", hidden = true },
	-- buffer navigation
	{ "<tab>", ":bnext<cr>", desc = "next buffer" },
	{ "<s-tab>", ":bprevious<cr>", desc = "previous buffer" },
	-- move current line up or down
	{ "<a-j>", "<esc>:m .+1<cr>", desc = "move line down" },
	{ "<a-k>", "<esc>:m .-2<cr>", desc = "move line up" },
	-- neovim config
	{ "<leader>ve", ":tabnew $MYVIMRC<cr>", desc = "Open neovim configuration file" },
	{ "<leader>vs", reload, desc = "Re-source neovim configuration file" },
	-- quicker save
	{ "<C-s>", ":w<cr>", desc = "Save current file" },
	{ "<C-s>", "<esc>:w<cr>", mode = "i", desc = "Save current file" },
	-- Fzf
	{ "<leader>f", group = "Find" },
	{ "<leader>ff", ":FzfLua files<cr>", desc = "find files" },
	{ "<leader>fg", ":FzfLua live_grep<cr>", desc = "live grep" },
	{ "<leader>fa", ":FzfLua<cr>", desc = "open FzfLua" },
}

wk.add(keymaps)
