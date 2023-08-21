local extension_path = vim.env.HOME .. "/.nix-profile/share/vscode/extensions/vadimcn.vscode-lldb"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb"

return {
  {
    "mfussenegger/nvim-dap",
    opts = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  },
}
