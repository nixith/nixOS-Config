return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,

          -- nix lang
          nls.builtins.code_actions.statix,
          nls.builtins.formatting.alejandra,
          nls.builtins.diagnostics.deadnix,
          nls.builtins.diagnostics.ruff,
          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },
}
