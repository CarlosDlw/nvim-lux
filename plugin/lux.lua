-- nvim-lux — plugin entrypoint
-- This file runs automatically when Neovim loads the plugin.
-- It performs lightweight bootstrap (filetype registration) without
-- requiring the user to call setup() for basic functionality.
-- Full LSP integration is enabled only after setup() is called.

-- Guard against double-loading
if vim.g.loaded_nvim_lux then
  return
end
vim.g.loaded_nvim_lux = true

-- Ensure .lx → lux filetype mapping is registered even when the user
-- never calls require("lux").setup().
-- (ftdetect/lux.lua also does this, but plugin/ loads before rtp ftdetect.)
if vim.filetype and vim.filetype.add then
  vim.filetype.add({ extension = { lx = "lux" } })
end

-- Expose the public API so `require("lux")` works.
-- No-op if the user never calls setup(); LSP stays inactive.
