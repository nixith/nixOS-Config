local BIN_PATH = vim.env.HOME .. "/.nix-profile/bin"
local LIB_PATH = vim.env.HOME .. "/.nix-profile/lib"
return {
{
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
  }
}
