require("nu").setup({
	use_lsp_features = false, -- Erst LSP deaktivieren
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nu",
  callback = function()
    print("Starting Nushell LSP...") -- Debugging
    vim.lsp.start({
      name = "nulsp",
      cmd = { "nu", "--lsp" },
      filetypes = { "nu" },
      root_dir = vim.fn.getcwd(),
      single_file_support = true,
      on_attach = function()
        print("Nushell LSP attached!")
      end,
    })
  end,
})
require("nvim-treesitter.configs").setup({
  ensure_installed = { "nu" }, -- Falls noch nicht vorhanden
  highlight = { enable = true },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nu",
  command = "TSEnable highlight",
})
