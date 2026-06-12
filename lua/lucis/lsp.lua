local M = {}

--- Register and start the lucis LSP server.
--- Tries nvim-lspconfig first; falls back to the native vim.lsp API.
---
--- @param cfg table lsp config block from M.config.lsp
function M.setup(cfg)
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok then
		M._setup_lspconfig(lspconfig, cfg)
	else
		M._setup_native(cfg)
	end
end

--- Register via nvim-lspconfig (preferred).
---
--- @param lspconfig table  the lspconfig module
--- @param cfg       table  lsp config block
function M._setup_lspconfig(lspconfig, cfg)
	local ok_configs, configs = pcall(require, "lspconfig.configs")
	if not ok_configs then
		vim.notify("[nvim-lucis] lspconfig.configs not available — falling back to native LSP", vim.log.levels.WARN)
		M._setup_native(cfg)
		return
	end

	-- Register the server only once
	if not configs.lucis then
		configs.lucis = {
			default_config = {
				cmd = cfg.cmd,
				filetypes = { "lucis" },
				root_dir = lspconfig.util.root_pattern(unpack(cfg.root_markers)),
				single_file_support = true,
				settings = cfg.settings,
			},
			docs = {
				description = [[
lucis Language Server.
Provided by the lucis compiler itself: `lucis lsp`.

The server supports LSP diagnostics, hover, go-to-definition,
completion, and formatting for `.lc` source files.
]],
				default_config = {
					root_dir = [[root_pattern(".git", "*.lc")]],
				},
			},
		}
	end

	lspconfig.lucis.setup({
		settings = cfg.settings,
		capabilities = cfg.capabilities,
	})
end

--- Fallback using the native vim.lsp client (no nvim-lspconfig required).
---
--- @param cfg table  lsp config block
function M._setup_native(cfg)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "lucis",
		group = vim.api.nvim_create_augroup("nvim_lucis_lsp", { clear = true }),
		callback = function(ev)
			vim.lsp.start({
				name = "lucis",
				cmd = cfg.cmd,
				root_dir = vim.fs.root(ev.buf, cfg.root_markers),
				settings = cfg.settings,
				capabilities = cfg.capabilities,
			})
		end,
	})
end

return M
