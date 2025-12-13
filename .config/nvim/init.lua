vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.o.backup = true
vim.o.backupdir = vim.env.HOME .. "/vimbackup/"

vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Make split windows open in new places, instead of clobbering what I'm
-- looking at.
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.backspace = indent,eol,start

vim.o.relativenumber = true

vim.o.wildmode = "longest,list"
--vim.o.wildoptions = "fuzzy"

vim.o.switchbuf = "usetab,newtab" -- for quicklists mainly

-- nmap <F2>b =a{``
-- nmap <Leader>f gg=G``
-- nmap [[ ]]%

-- Make Ctrl-W do what I mean
vim.keymap.set('i', '<C-W>', '<Esc><C-W>')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " Use 2-space indentation in ruby
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal equalprg="ruby-beautify -s -c 2"
  autocmd FileType cucumber setlocal softtabstop=2
  autocmd FileType cucumber setlocal shiftwidth=2

  " Use 2-space indentation in yaml
  autocmd FileType yaml setlocal softtabstop=2
  autocmd FileType yaml setlocal shiftwidth=2

  " Use perltidy to indent perl
  autocmd FileType perl setlocal equalprg=perltidy

  autocmd FileType rust setlocal equalprg=rustfmt

  autocmd filetype crontab setlocal nobackup nowritebackup

  autocmd FileType make setlocal shiftwidth=0
  autocmd FileType make setlocal noexpandtab
  autocmd FileType make setlocal softtabstop=0

  autocmd FileType javascript setlocal softtabstop=2
  autocmd FileType javascript setlocal shiftwidth=2
  autocmd FileType javascript setlocal equalprg="prettier --write"

  autocmd FileType c,cpp setlocal shiftwidth=4
  autocmd FileType c,cpp setlocal softtabstop=4
  " autocmd FileType c,cpp setlocal equalprg="clang-format --style=file"

  " See help:restore-position regarding the command:
  " autocmd BufWrite *.c,*.cc,*.cpp,*.h execute "normal msHmtgg=G'tzt`s"
  function ClangFormatBuffer()
    if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
      let cursor_pos = getpos('.')
      :%!clang-format
      call setpos('.', cursor_pos)
    endif
  endfunction

  autocmd BufWritePre *.h,*.hpp,*.c,*.cpp :call ClangFormatBuffer()

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
]])

require("config.lazy")
