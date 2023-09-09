return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      -- "mason.nvim",
      --"williamboman/mason-lspconfig.nvim",
    },
  },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false },
}
