local format_pmd = "%f:%l: %m"

return {
  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
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
        pmd = {

          cmd = "pmd",
          stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
          append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
          args = { "-R", vim.env.HOME .. "/.local/share/nvim/lintConfig/csc_pmd.xml", "-f", "emacs", "-d" }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
          ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
          parser = require("lint.parser").from_errorformat(format_pmd, {
            source = "pmd",
            severity = "W",
          }),
        },
      },
    },
  },
}
