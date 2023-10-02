local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)
-- set tabs
local bufnr = vim.api.nvim_get_current_buf()
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.autoindent = true
vim.opt_local.smarttab = true
--set shiftwidth=4 smarttab

-- change to cmp_nvim_lsp.default_capabilities
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.env.HOME .. "/.cache/jdtls/" .. project_name

local config = {
  cmd = {
    vim.env.HOME .. "/.nix-profile/bin/jdt-language-server", -- path to jdtls
    "-data",
    workspace_dir, -- can be anything, just know it modifies stuff
  },
  handlers = {
    ["language/status"] = function(_, result)
      -- print(result)
    end,
    ["$/progress"] = function(_, result, ctx)
      -- disable progress updates.
    end,
  },
  settings = {
    eclipse = {
      downloadSources = true,
    },
    implementationsCodeLens = {
      enable = true,
    },
    signatureHelp = {
      enabled = true,
    },
    completion = {
      favoriteStaticMembers = {
        "org.junit.Assert.*",
        "org.junit.Assume.*",
        "org.junit.jupiter.api.Assertions.*",
        "org.junit.jupiter.api.Assumptions.*",
        "org.junit.jupiter.api.DynamicContainer.*",
        "org.junit.jupiter.api.DynamicTest.*",
      },
    },
  },
  init_options = {
    bundles = {
      vim.fn.glob(
        vim.env.HOME
          .. "/.nix-profile/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar",
        true
      ),
      vim.fn.glob(
        vim.env.HOME
          .. "/.nix-profile/share/vscode/extensions/vscjava.vscode-java-test/server/com.microsoft.java.test.plugin-*.jar",
        true
      ),
    },
  },
  root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,
  capabilities = vim.deepcopy(capabilities), -- taken from lazyVim
}
require("jdtls").start_or_attach(config)
