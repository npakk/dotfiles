vim.g.completion_enable_snippet = 'snippets.nvim'
vim.g.completion_chain_complete_list = {
  default = {
    {complete_items = {'lsp', 'snippet', 'buffers'}}
  },
}
