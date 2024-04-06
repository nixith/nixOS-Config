return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          python = ".venv/bin/python",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    --TODO: Fix python debug
    config = function()
      --local path = require("mason-registry").get_package("debugpy"):get_install_path()
      --require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },
}
