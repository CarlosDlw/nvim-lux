local M = {}

--- Default configuration
M.defaults = {
  --- LSP integration
  lsp = {
    --- Enable automatic LSP attachment for .lx buffers
    enabled = true,
    --- Command to start the Lux language server
    cmd = { "lux", "lsp" },
    --- Root markers used to detect the project root
    root_markers = { ".git", "*.lx" },
    --- Extra settings forwarded to the language server
    settings = {},
    --- Map of LSP capabilities to override
    capabilities = nil,
  },
  --- Automatically format the buffer on save (requires LSP)
  format_on_save = false,
}

--- Active configuration (merged with user opts in setup())
M.config = vim.deepcopy(M.defaults)

--- Whether setup() has been called
M._initialized = false

--- Setup nvim-lux.
---
--- @param opts table|nil Optional configuration table (deep-merged with defaults).
---
--- Example (lazy.nvim spec):
---   { "CarlosDlw/nvim-lux", opts = {} }
---
--- Example (manual):
---   require("lux").setup({
---     lsp = { enabled = true, cmd = { "lux", "lsp" } },
---     format_on_save = false,
---   })
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
  M._initialized = true

  if M.config.lsp.enabled then
    require("lux.lsp").setup(M.config.lsp)
  end

  if M.config.format_on_save then
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.lx",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

return M
