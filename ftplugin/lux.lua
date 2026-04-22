-- Lux filetype settings — applied whenever a .lx buffer is opened

vim.bo.commentstring   = "// %s"
vim.bo.tabstop         = 4
vim.bo.shiftwidth      = 4
vim.bo.softtabstop     = 4
vim.bo.expandtab       = true
vim.bo.textwidth       = 100

-- treat <> as bracket pairs (for generics: vec<T>, map<K,V>)
vim.opt_local.matchpairs:append("<:>")
