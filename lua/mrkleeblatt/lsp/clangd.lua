local askEXE = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end


local dap = require("dap")
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}
dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = askEXE,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
	{
		name = "Select and attach to process",
		type = "gdb",
		request = "attach",
		program = askEXE,
		pid = function()
			local name = vim.fn.input('Executable name (filter): ')
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = '${workspaceFolder}'
	},
}

require("lspconfig").clangd.root_dir = function(fname)
	return require("lspconfig.util").root_pattern(
		"devm.c",
		"compile_commands.json"
	)(fname)
end

require("lspconfig").clangd.setup({
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end
})
