local BIN_PATH = vim.env.HOME .. "/.nix-profile/bin/"
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
        ["typst-preview"] = BIN_PATH .. "typst-preview",
        ["websocat"] = BIN_PATH .. "websocat",
      },
    },
  },
}
