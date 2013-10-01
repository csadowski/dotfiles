if has("gui_running") || &t_Co >= 256
	colorscheme sahara
else
	colorscheme maddox
endif
if has("autocmd")
    filetype on
    filetype indent on
    filetype plugin on
endif
set hidden
set nu
set wildmenu
set wildmode=longest,list
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp
set incsearch
set hlsearch
set linebreak
set backupdir=~/.vim/backup
set backupskip+=*/shm/*
set directory=~/.vim/swap
" Don't swap sensitive files
    if has('autocmd')
        augroup swapskip
            autocmd!
            silent! autocmd BufNewFile,BufReadPre
                \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
                \ setlocal noswapfile
        augroup END
    endif
" Don't track changes to sensitive files
    if has('autocmd')
        augroup undoskip
            autocmd!
            silent! autocmd BufWritePre
                \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
                \ setlocal noundofile
        augroup END
    endif
set smartcase
set splitbelow
set splitright
set pastetoggle=<F10>
nnoremap <C-l> :nohlsearch<CR><C-l>
nnoremap <leader>i :set incsearch!<CR>
nnoremap <leader>h :set hlsearch!<CR>
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch
cmap w!! w !sudo tee >/dev/null %
" compile and run current buffer (C/C++)
map <F8> :w <CR> :!g++ -Wall -O % -o %< && ./%< <CR>
" compile all buffers, but don't run them (C/C++)
map <ESC><F8> :wa <CR> :silent bufdo !g++ -Wall -O % -o %< <CR> <C-L>
" Typos
if has('user_commands')
    command! -bang -complete=file -nargs=? E e<bang> <args>
    command! -bang -complete=file -nargs=? W w<bang> <args>
    command! -bang -complete=file -nargs=? WQ wq<bang> <args>
    command! -bang -complete=file -nargs=? Wq wq<bang> <args>
    command! -bang Q q<bang>
    command! -bang Qa qa<bang>
    command! -bang QA qa<bang>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
endif
" Formatting
set expandtab
set autoindent
" If we have Vim 7.4, add j to the format options to get rid of comment
" leaders when joining lines
if v:version >= 704
    set formatoptions+=j
endif
set smarttab
set nojoinspaces
set shiftround
set shiftwidth=4
set softtabstop=4
set tabstop=4
" Used for double-spacing after prose; defines a sentence as ending after 2
" periods
" set cpo+=J
" For latex-suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
" vundle stuff
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
Bundle 'gmarik/vundle'
" YouCompleteMe repo
Bundle 'Valloric/YouCompleteMe'
