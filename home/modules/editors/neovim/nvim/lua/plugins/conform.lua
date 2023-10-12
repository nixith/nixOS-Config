return {
  {
    "stevearc/conform.nvim",
    dependencies = {},
    opts = {
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
        ["*sh"] = { { "shellcheck", "shellharden", "shfmt" } },
        ["*"] = { "injected" },
      },
    },
  },
}
