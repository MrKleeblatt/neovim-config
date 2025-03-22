local os = {
	iswin32 = vim.fn.has("win32") == 1,
	ismac = vim.fn.has("mac") == 1,
	iswsl = vim.fn.has("wsl") == 1,
	islinux = vim.fn.has("linux") == 1,
}

vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = {
		"*.png", "*.jpg", "*.jpeg", "*.gif", "*.pdf", "*.ico", "*.tga"
	},
	callback = function()
		if os.ismac then
			vim.cmd([[silent exe '!open ' shellescape(expand('<afile>'))]])
			vim.cmd([[Bdelete]])
		elseif os.islinux then
			vim.cmd([[silent exe '!xdg-open ' shellescape(expand('<afile>'))]])
			vim.cmd([[Bdelete]])
		end
	end
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})


-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
