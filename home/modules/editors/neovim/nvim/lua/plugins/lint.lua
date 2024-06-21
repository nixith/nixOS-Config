local format_pmd = "%f:%l: %m"

return {
  {
    "mfussenegger/nvim-lint",
    --event = "LazyFile", lazyvim has reccomended options
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        c = { "lang-tidy" },
        nix = { "nix", "statix" },
        fish = { "fish" },
        java = { "checkstyle", "pmd" },
        json = { "jsonlint" },
        python = { "ruff" },
        lua = { "selene" },
        css = { "stylelint" },
        ["*sh"] = { "ShellCheck" },
        --["*"] = { "languagetool" },
      },

      linters = {
        -- Example of using selene only when a selene.toml file is present
        selene = {
          -- `condition` is another LazyVim extension that allows you to
          -- dynamically enable/disable linters based on the context.
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
