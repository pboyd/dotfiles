set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Rename'
Plugin 'fatih/vim-go'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scratch.vim'
Plugin 'The-NERD-tree'
Plugin 'sheerun/vim-polyglot'
Plugin 'dense-analysis/ale'
Plugin 'majutsushi/tagbar'
Plugin 'sebdah/vim-delve'
"Plugin 'github/copilot.vim'
Plugin 'ellisonleao/gruvbox.nvim'
"Plugin 'rust-lang/rust.vim'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

"let g:copilot_enabled = 0

set background=dark
colorscheme gruvbox

set backup
set backupdir=$HOME/vimbackup/

set softtabstop=4
set shiftwidth=4
set expandtab
"set smartindent

" Make split windows open in new places, instead of clobbering what I'm
" looking at.
set splitbelow
set splitright

set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set relativenumber

set wildmode=longest,list
set switchbuf=usetab,newtab " for quicklists mainly
set autowrite

let mapleader=","

nmap <F2>b =a{``
nmap <Leader>f gg=G``
nmap [[ ]]%
nmap <Leader>t :NERDTreeToggle<CR>
nmap <Leader>g :TagbarToggle<CR>

" Make Ctrl-W do what I mean
imap <C-W> <Esc><C-W>

let g:go_fmt_command = "goimports"
let g:go_def_reuse_buffer = 1

" This is broken for some reason:
let g:go_auto_type_info = 1
let g:go_template_autocreate = 0
let g:go_def_mapping_enabled = 0

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

let g:rustfmt_autosave = 1

" Only add fold markers when compiled with support for folding
if has("folding")
   set foldmethod=marker
   set foldmarker=\=pod,\=cut
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
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

  " Use gofmt to indent go
  autocmd FileType go setlocal equalprg=gofmt
  " Go uses tabs, you see..
  autocmd FileType go setlocal shiftwidth=0
  autocmd FileType go setlocal noexpandtab
  autocmd FileType go setlocal softtabstop=0

  autocmd FileType go nmap gd <Plug>(go-def-tab)
  autocmd FileType go nmap gD <Plug>(go-def)
  autocmd FileType go nmap <Leader><Tab> :GoAlternate<CR>
  autocmd FileType go nmap gc :GoCallers<CR>
  autocmd FileType go nmap gb :DlvToggleBreakpoint<CR>

  " Avoid 'Hit ENTER to continue' with go_auto_type_info
  autocmd FileType go setlocal cmdheight=2

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
else
    set autoindent
endif " has("autocmd")
