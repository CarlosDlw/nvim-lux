# nvim-lux

Neovim plugin for the [Lux programming language](https://github.com/CarlosDlw/Lux).

Provides:
- Filetype detection for `.lx` files
- Syntax highlighting (Vim regex, zero dependencies)
- Tree-sitter highlight queries (ready for when a parser is available)
- LSP integration via `lux lsp` — diagnostics, hover, completion, go-to-definition, formatting
- Sensible buffer defaults (indent, comments, bracket pairs)

---

## Requirements

| Requirement | Notes |
|---|---|
| Neovim ≥ 0.10 | `vim.lsp.start` API |
| `lux` binary in `$PATH` | Provides `lux lsp` language server |
| `nvim-lspconfig` (optional) | Preferred; falls back to native `vim.lsp` |

---

## Installation

### lazy.nvim (recommended)

Minimal — just filetype + LSP:

```lua
{
  "CarlosDlw/nvim-lux",
  ft = "lux",
  opts = {},
}
```

Full options:

```lua
{
  "CarlosDlw/nvim-lux",
  ft = "lux",
  opts = {
    lsp = {
      enabled  = true,
      cmd      = { "lux", "lsp" },       -- path to the lux binary
      root_markers = { ".git", "*.lx" }, -- project root detection
      settings     = {},                 -- extra settings for the server
      capabilities = nil,                -- override LSP capabilities
    },
    format_on_save = false,              -- auto-format with lux lsp on save
  },
}
```

### LazyVim extra

In your LazyVim config (`~/.config/nvim/lua/plugins/lux.lua`):

```lua
return {
  {
    "CarlosDlw/nvim-lux",
    ft = "lux",
    opts = {},
    -- Optional: wire up with blink.cmp or nvim-cmp capabilities
    config = function(_, opts)
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        opts.lsp = opts.lsp or {}
        opts.lsp.capabilities = blink.get_lsp_capabilities()
      end
      require("lux").setup(opts)
    end,
  },
}
```

### With nvim-lspconfig already configured

If you manage all your servers via `lspconfig`, you can skip the plugin's
built-in LSP setup and configure it manually:

```lua
{
  "CarlosDlw/nvim-lux",
  ft = "lux",
  opts = { lsp = { enabled = false } },  -- disable auto-setup
},
{
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- nvim-lux registers the "lux" server config automatically.
      -- You just need to reference it here:
      lux = {},
    },
  },
},
```

---

## Language Server

The LSP server ships inside the Lux compiler:

```sh
lux lsp          # starts the language server on stdin/stdout
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

`queries/lux/highlights.scm` contains highlight queries ready for when a
compiled `tree-sitter-lux` parser becomes available.

Until then, `syntax/lux.vim` provides full Vim-regex-based highlighting with
no external dependencies.

---

## License

MIT
