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
" Formatting
set expandtab
set autoindent
silent! set formatoptions+=j
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
