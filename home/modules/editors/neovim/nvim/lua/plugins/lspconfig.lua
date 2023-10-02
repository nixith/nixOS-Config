local languages = {
  lua = {},
  java = {
    lintCommand = "checkstyle -c"
      .. vim.env.HOME
      .. "~/.local/share/nvim/lintConfig/csc116_checks_jenkins.xml ${INPUT}",
    lintFormats = "[%tARN] %f:%l:%c: %m [%r]",
  },
}

return {

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "simrat39/rust-tools.nvim" },
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
    },
    opts = {
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = { formatting_options = nil, timeout_ms = nil },

      --------- #### ---------
      -- LSP Server Settings -
      ---@type lspconfig.options
      servers = {
        -- technically not a language server, but a lint hoster

        --- configuration languages
        -- json
        jsonls = {},
        --yaml
        yamlls = {},

        -- nix
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = { command = { "alejandra" } },
              nix = {
                flake = {
                  autoArchive = true,
                  autoEvalInputs = true,
                },
              },
            },
          },
        },

        nixd = {},

        --- programming lanugages
        -- lua
        lua_ls = {
          filetypes = { "lua" },
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
            },
          },
        },
        -- python
        ruff_lsp = {},
        pylyzer = {},

        -- typst
        typst_lsp = {
          settings = {
            exportPdf = "onType", -- Choose onType, onSave or never.
            -- serverPath = "~/.nix-profile/bin/typst-lsp", -- Normally, there is no need to uncomment it.
          },
        },
        ltex = {
          settings = {
            ltex = {
              language = "en-US",
            },
          },
          filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "typst" },
        },
      },
      --------- #### ---------
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- ## Rust Config Done in other File ##

        -- rust_analyzer = function(_, opts)
        --  require("rust-tools").setup({ server = opts })
        --  return true
        -- end,

        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
}
