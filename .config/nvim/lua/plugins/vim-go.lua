vim.g.go_fmt_command = "goimports"
vim.g.go_def_reuse_buffer = 1

vim.g.go_auto_type_info = 1
vim.g.go_template_autocreate = 0
vim.g.go_def_mapping_enabled = 0

vim.cmd([[
augroup vimGo
au!
  autocmd FileType go nmap gd <Plug>(go-def-tab)
  autocmd FileType go nmap gD <Plug>(go-def)
  autocmd FileType go nmap <Leader><Tab> :GoAlternate<CR>
  autocmd FileType go nmap gc :GoCallers<CR>

  autocmd FileType go setlocal shiftwidth=0
  autocmd FileType go setlocal noexpandtab
  autocmd FileType go setlocal softtabstop=0

  " Avoid 'Hit ENTER to continue' with go_auto_type_info
  autocmd FileType go setlocal cmdheight=2
augroup END
]])

return {
    "fatih/vim-go"
}
