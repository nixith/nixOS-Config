return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {},
    opts = function(_, opts)
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          --fish
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,

          -- lua
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.selene,

          -- rust
          -- nls.builtins.formatting.rustfmt,

          -- shell
          nls.builtins.code_actions.shellcheck,
          nls.builtins.formatting.beautysh,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.shellharden,

          -- general
          nls.builtins.code_actions.ts_node_action,

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
          nls.builtins.hover.printenv,
        },
      }
    end,
  },
}
