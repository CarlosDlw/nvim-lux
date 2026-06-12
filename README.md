# nvim-lucis

Neovim plugin for the [lucis programming language](https://github.com/CarlosDlw/lucis).

Provides:
- Filetype detection for `.lc` files
- Syntax highlighting (Vim regex, zero dependencies)
- Tree-sitter highlight queries (ready for when a parser is available)
- LSP integration via `lucis lsp` — diagnostics, hover, completion, go-to-definition, formatting
- Sensible buffer defaults (indent, comments, bracket pairs)

---

## Requirements

| Requirement | Notes |
|---|---|
| Neovim ≥ 0.10 | `vim.lsp.start` API |
| `lucis` binary in `$PATH` | Provides `lucis lsp` language server |
| `nvim-lspconfig` (optional) | Preferred; falls back to native `vim.lsp` |

---

## Installation

### lazy.nvim (recommended)

Minimal — just filetype + LSP:

```lua
{
  "CarlosDlw/nvim-lucis",
  ft = "lucis",
  opts = {},
}
```

Full options:

```lua
{
  "CarlosDlw/nvim-lucis",
  ft = "lucis",
  opts = {
    lsp = {
      enabled  = true,
      cmd      = { "lucis", "lsp" },       -- path to the lucis binary
      root_markers = { ".git", "*.lc" }, -- project root detection
      settings     = {},                 -- extra settings for the server
      capabilities = nil,                -- override LSP capabilities
    },
    format_on_save = false,              -- auto-format with lucis lsp on save
  },
}
```

### LazyVim extra

In your LazyVim config (`~/.config/nvim/lua/plugins/lucis.lua`):

```lua
return {
  {
    "CarlosDlw/nvim-lucis",
    ft = "lucis",
    opts = {},
    -- Optional: wire up with blink.cmp or nvim-cmp capabilities
    config = function(_, opts)
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        opts.lsp = opts.lsp or {}
        opts.lsp.capabilities = blink.get_lsp_capabilities()
      end
      require("lucis").setup(opts)
    end,
  },
}
```

### With nvim-lspconfig already configured

If you manage all your servers via `lspconfig`, you can skip the plugin's
built-in LSP setup and configure it manually:

```lua
{
  "CarlosDlw/nvim-lucis",
  ft = "lucis",
  opts = { lsp = { enabled = false } },  -- disable auto-setup
},
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- nvim-lucis registers the "lucis" server config automatically.
      -- You just need to reference it here:
      lucis = {},
    },
  },
},
```

---

## Language Server

The LSP server ships inside the lucis compiler:

```sh
lucis lsp          # starts the language server on stdin/stdout
```

Supported LSP features:

| Feature | Status |
|---|---|
| Diagnostics | ✓ |
| Hover | ✓ |
| Go-to-definition | ✓ |
| Completion | ✓ |
| Formatting | ✓ |
| Signature help | ✓ |
| Document symbols | ✓ |

---

## Tree-sitter

`queries/lucis/highlights.scm` contains highlight queries ready for when a
compiled `tree-sitter-lucis` parser becomes available.

Until then, `syntax/lucis.vim` provides full Vim-regex-based highlighting with
no external dependencies.

---

## License

MIT
