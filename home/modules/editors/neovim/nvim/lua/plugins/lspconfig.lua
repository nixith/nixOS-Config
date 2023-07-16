return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },

      --------- #### ---------
      -- LSP Server Settings -
      ---@type lspconfig.options
      servers = {
        --- configuration languages
        -- json
        jsonls = {},

        -- nix
        nil_ls = {
          settings = {
            ["nil"] = {
              formatting = {
                command = { "alejandra" },
              },
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
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        --python
        ruff_lsp = {},
        pylyzer = {},
        pyright = {},

        --rust
        rust_analyzer = {
          -- mason = false,
          -- settings = {
          --   ["rust-analyzer"] = {
          --     imports = {
          --       granularity = {
          --         group = "module",
          --       },
          --       prefix = "self",
          --     },
          --     cargo = {
          --       buildScripts = {
          --         enable = true,
          --       },
          --     },
          --     procMacro = {
          --       enable = true,
          --     },
          --   },
          -- },
          checkOnSave = {
            command = "clippy",
          },
        },
      },
      --------- #### ---------
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        rust_analyzer = function(_, opts)
          require("rust-tools").setup({ server = opts })
          return true
        end,
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
