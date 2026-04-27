-- Lux filetype settings — applied whenever a .lx buffer is opened

vim.bo.commentstring   = "// %s"
vim.bo.tabstop         = 2
vim.bo.shiftwidth      = 2
vim.bo.softtabstop     = 2
vim.bo.expandtab       = true
vim.bo.textwidth       = 100
vim.bo.autoindent      = true
vim.bo.cindent         = true
vim.bo.smartindent     = false
vim.bo.indentexpr      = ""

-- treat <> as bracket pairs (for generics: vec<T>, map<K,V>)
vim.opt_local.matchpairs:append("<:>")
