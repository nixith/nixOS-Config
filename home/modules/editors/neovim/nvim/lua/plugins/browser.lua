local plugins = {
  "glacambre/firenvim",
  build = ":call firenvim#install(0)",
  init = function()
    vim.o.laststatus = 0
    vim.g.firenvim_config.localSettings[".*"] =
      { selector = 'textarea:not([readonly], [aria-readonly]), div[role="textbox"]', takeover = "never" }
  end,
}

return plugins
