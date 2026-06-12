-- nvim-lucis — plugin entrypoint
-- This file runs automatically when Neovim loads the plugin.
-- It performs lightweight bootstrap (filetype registration) without
-- requiring the user to call setup() for basic functionality.
-- Full LSP integration is enabled only after setup() is called.

-- Guard against double-loading
if vim.g.loaded_nvim_lucis then
	return
end
vim.g.loaded_nvim_lucis = true

-- Ensure .lc → lucis filetype mapping is registered even when the user
-- never calls require("lucis").setup().
-- (ftdetect/lucis.lua also does this, but plugin/ loads before rtp ftdetect.)
if vim.filetype and vim.filetype.add then
	vim.filetype.add({ extension = { lc = "lucis" } })
end

-- Expose the public API so `require("lucis")` works.
-- No-op if the user never calls setup(); LSP stays inactive.
