local M = {}

--- Register and start the Lux LSP server.
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
    vim.notify("[nvim-lux] lspconfig.configs not available — falling back to native LSP", vim.log.levels.WARN)
    M._setup_native(cfg)
    return
  end

  -- Register the server only once
  if not configs.lux then
    configs.lux = {
      default_config = {
        cmd            = cfg.cmd,
        filetypes      = { "lux" },
        root_dir       = lspconfig.util.root_pattern(unpack(cfg.root_markers)),
        single_file_support = true,
        settings       = cfg.settings,
      },
      docs = {
        description = [[
Lux Language Server.
Provided by the Lux compiler itself: `lux lsp`.

The server supports LSP diagnostics, hover, go-to-definition,
completion, and formatting for `.lx` source files.
]],
        default_config = {
          root_dir = [[root_pattern(".git", "*.lx")]],
        },
      },
    }
  end

  lspconfig.lux.setup({
    settings     = cfg.settings,
    capabilities = cfg.capabilities,
  })
end

--- Fallback using the native vim.lsp client (no nvim-lspconfig required).
---
--- @param cfg table  lsp config block
function M._setup_native(cfg)
  vim.api.nvim_create_autocmd("FileType", {
    pattern  = "lux",
    group    = vim.api.nvim_create_augroup("nvim_lux_lsp", { clear = true }),
    callback = function(ev)
      vim.lsp.start({
        name         = "lux",
        cmd          = cfg.cmd,
        root_dir     = vim.fs.root(ev.buf, cfg.root_markers),
        settings     = cfg.settings,
        capabilities = cfg.capabilities,
      })
    end,
  })
end

return M
