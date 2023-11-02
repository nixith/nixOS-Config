return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Taken From lazyvim websitre
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)

      -- Here's my own stuff
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.typst = {
        install_info = {
          url = "https://github.com/uben0/tree-sitter-typst.git", -- local path or git repo
          files = { "src/parser.c" "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
          -- optional entries:
          branch = "main", -- default branch in case of git repo if different from master
          requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
        filetype = "typst", -- if filetype does not match the parser name
      }
    end,
  },
}
