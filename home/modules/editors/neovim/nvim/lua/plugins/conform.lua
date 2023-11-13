return {
  {
    "stevearc/conform.nvim",
    dependencies = {},
    opts = {
      lsp_fallback = true,
      formatters_by_ft = {
        nix = { "alejandra" },
        lua = { "stylua" },
        bib = { "bibtex-tidy" },
        fish = { "fish_indent" },
        python = { { "ruff_fix", "ruff_format" } },
        rust = { "rustfmt" },
        css = { "sylint" },
        toml = { "taplo" },
        yaml = { "yamlfmt" },
        typst = { "typstfmt" },
        ["*sh"] = { { "shellcheck", "shellharden", "shfmt" } },
        -- ["*"] = { "injected" }, -- commented out so that LSP formatting will load
      },
    },
  },
}
