return {
  --{ "davidmh/cspell.nvim", dependencies = "nvimtools/none-ls.nvim" },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    enable = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      -- local cspell = require("cspell")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          --fish
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,

          --java
          nls.builtins.diagnostics.checkstyle.with({
            extra_args = { "-c", vim.env.HOME .. "/.local/share/nvim/lintConfig/csc116_checks_jenkins.xml" },
            args = { "-f", "sarif", "$ROOT", "-x", ".direnv/", "-x", "project_docs/", "-x", "lib" },
          }),

          -- markup languages
          --- yaml
          nls.builtins.diagnostics.yamllint,
          nls.builtins.formatting.yamlfmt,

          -- lua
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.selene,

          -- git
          nls.builtins.diagnostics.commitlint,
          nls.builtins.code_actions.gitsigns,

          -- rust
          -- nls.builtins.formatting.rustfmt,

          -- shell
          nls.builtins.code_actions.shellcheck,
          nls.builtins.formatting.beautysh,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.shellharden,

          -- nix lang
          nls.builtins.code_actions.statix,
          nls.builtins.formatting.alejandra,
          nls.builtins.diagnostics.deadnix,

          --python
          nls.builtins.diagnostics.ruff,
          nls.builtins.formatting.ruff,
          -- nls.builtins.diagnostics.flake8,

          -- text
          nls.builtins.hover.dictionary,
          nls.builtins.code_actions.proselint,
          nls.builtins.completion.spell,
          nls.builtins.hover.printenv,
          --cspell.diagnostics,
          --cspell.code_actions,
          nls.builtins.diagnostics.textlint,
          nls.builtins.diagnostics.typos,

          --md
          nls.builtins.diagnostics.markdownlint,

          -- css
          nls.builtins.diagnostics.stylelint,
        },
      }
    end,
  },
}
