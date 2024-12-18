return {
  {
    "https://git.sr.ht/~nedia/auto-save.nvim",
    event = { "BufReadPre" },
    opts = {
      events = { "FocusLost", "BufDelete" },
      silent = false,
      exclude_ft = { "neo-tree" },
    },
  },
}
