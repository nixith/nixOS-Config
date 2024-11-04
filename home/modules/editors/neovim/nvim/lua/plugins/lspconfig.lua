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
      -- { "folke/neodev.nvim", opts = {}, dependencies = { "folke/neoconf.nvim" } },
    },
    opts = {
      -- add any global capabilities here

      diagnostics = {
        underline = true,
        update_in_insert = true,
        virutal_text = true,
        virtual_lines = true,

        float = {
          border = "rounded",
          source = "always",
        },
      },
      codelens = {
        enabled = true, -- for some reason both exist
      },

      -- Automatically format on save
      --autoformat = true,

      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = { formatting_options = nil, timeout_ms = nil },

      --------- #### ---------
      -- LSP Server Settings -
      ---@type lspconfig.options
      servers = {
        fennel_ls = {},

        --- configuration languages
        -- json
        jsonls = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
          cmd = { "vscode-json-languageserver", "--stdio" },
        },
        --yaml
        yamlls = {},
        terraformls = {},
        ansiblels = {},

        -- nix
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = { command = { "alejandra" } },
              nix = {
                maxMemoryMB = 5120,
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
        -- C
        clangd = {},
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
        basedpyright = {
          analysis = {
            -- autoSearchPaths = true,
            -- diagnosticMode = "openFilesOnly",
            -- useLibraryCodeForTypes = true,
          },
        },
        -- julia
        julials = {},
        -- gleam
        gleam = {},

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
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   enabled = false,
  --   opts = function()
  --     local M = {}
  --     M.ensure_installed = {}
  --     M.automatic_installation = false
  --     return M
  --   end,
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   enabled = false,
  --   opts = function()
  --     local M = {}
  --     M.ensure_installed = {}
  --     M.automatic_installation = false
  --     return M
  --   end,
  -- },
  -- { "williamboman/mason.nvim", enabled = false },
}
