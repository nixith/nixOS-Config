local BIN_PATH = vim.env.HOME .. "/.nix-profile/bin"
local LIB_PATH = vim.env.HOME .. "/.nix-profile/lib"
return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        -- remove mason dependency
        "mfussenegger/nvim-dap-python",
        config = function()
          if vim.fn.has("win32") == 1 then
            require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
          else
            -- remove mason usage - we don't support it
            -- require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
            require("dap-python").setup(BIN_PATH .. "/python") -- make sure global python has debugpy
          end
        end,
      },
    },
    config = function()
      --- do NOT use mason-nvim-dap
      -- ~~load mason-nvim-dap here, after all adapters have been setup~~
      --  require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
}
