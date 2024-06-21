return {

  {
    "neovim/nvim-lspconfig",
    opts = {

      ---@type lspconfig.options
      servers = {
        tinymist = {},
      },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    opts = {
      dependencies_bin = {
        ["typst-preview"] = nil,
        ["websocat"] = nil,
      },
    },
  },
}
