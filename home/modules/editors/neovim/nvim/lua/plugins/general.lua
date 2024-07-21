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
  -- {
  --   "sontungexpt/better-diagnostic-virtual-text",
  --   event = "LspAttach",
  --   opts = {
  --     ui = {
  --       wrap_line_after = false, -- Wrap the line after this length to avoid the virtual text is too long
  --       left_kept_space = 3, --- The number of spaces kept on the left side of the virtual text, make sure it enough to custom for each line
  --       right_kept_space = 3, --- The number of spaces kept on the right side of the virtual text, make sure it enough to custom for each line
  --       arrow = "  ",
  --       up_arrow = "  ",
  --       down_arrow = "  ",
  --       above = false, -- The virtual text will be displayed above the line
  --     },
  --     inline = true,
  --   },
  --   config = function(_)
  --     require("better-diagnostic-virtual-text").setup(opts)
  --   end,
  -- },
  {
    "chrisgrieser/nvim-rip-substitute",
    keys = {
      {
        "<leader>fs",
        function()
          require("rip-substitute").sub()
        end,
        mode = { "n", "x" },
        desc = " rip substitute",
      },
    },
  },
}
