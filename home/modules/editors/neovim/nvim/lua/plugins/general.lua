return {
  {
    "elkowar/yuck.vim",
    ft = "yuck",
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    --lazy = false,
  },

  {
    "ravibrock/spellwarn.nvim",
    event = "VeryLazy",
    config = true,
  },

  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({})
    end,
    ft = "markdown",
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
    lazy = false,
  },
}
