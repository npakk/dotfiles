vim.g.completion_chain_complete_list = {
  default = {
    {complete_items = {'lsp','snippet', 'buffers'}}
  },
}
vim.g.completion_enable_snippet = 'snippets.nvim'
require'lspconfig'.solargraph.setup{on_attach=require'completion'.on_attach}
