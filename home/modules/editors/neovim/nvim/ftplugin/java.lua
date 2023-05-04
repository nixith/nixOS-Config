local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

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
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  capabilities = vim.deepcopy(capabilities), -- taken from lazyVim
}
require("jdtls").start_or_attach(config)
