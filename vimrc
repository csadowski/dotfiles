" Pathogen stuff
call pathogen#infect()
call pathogen#helptags()

if has("gui_running") || &t_Co >= 256
	colorscheme sahara
else
	colorscheme maddox
endif
"Make background transparent
hi Normal ctermbg=NONE
if has("autocmd")
    filetype on
    filetype indent on
    filetype plugin on
endif
set hidden
" Enable hybrid line numbers
set number
set relativenumber

set wildmenu
set wildmode=longest,list
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp
set incsearch
set hlsearch
set linebreak
" Search only in unfolded text
set fdo-=search
set modeline " Needed to enable in-comment setting changes
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
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
nnoremap <C-l> :nohlsearch<CR><C-l>
nnoremap <leader>i :set incsearch!<CR>
nnoremap <leader>h :set hlsearch!<CR>
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch
cmap w!! w !sudo tee >/dev/null %
" compile and run current buffer (C/C++)
"map <F8> :w \| :!perl -c % <CR>
"map <F8> :w \| :!g++ -Wall -O % -o %< && ./%< <CR>
" map <F8> :w <CR> :!g++ -Wall -O % -o %< && ./%< <CR> " this appears to cause
" a race condition on newly-created files, e.g. vim file.cpp
" compile all buffers, but don't run them (C/C++)
"map <ESC><F8> :wa \| :silent bufdo !g++ -Wall -O % -o %< <CR> <C-L>
" run program in the current buffer
"map <F5> :!./% <CR>
map <F5> :wa \| :!perl ./% <CR>
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
set ignorecase
" Used for double-spacing after prose; defines a sentence as ending after 2
" periods
" set cpo+=J
" For latex-suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
au BufWritePost *.tex silent call Tex_RunLaTeX()
" vundle stuff
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
" let Vundle manage Vundle
""Bundle 'gmarik/vundle'
" YouCompleteMe repo
let g:ycm_confirm_extra_conf = 0
""Bundle 'Valloric/YouCompleteMe'
" Syntastic repo
let g:syntastic_full_redraws = 0 " fixes screen flicker
let g:syntastic_perl_perlcritic_args = '--brutal'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_perl_checkers  = ["perl", "perlcritic"]
let g:syntastic_enable_perl_checker = 1
nnoremap <F2> :lprev<cr>
nnoremap <F3> :lnext<cr>
"Bundle 'scrooloose/syntastic'
" vim-auto-save repo
"Bundle '907th/vim-auto-save'
autocmd BufNewFile,BufRead caseNotes.txt :AutoSaveToggle
autocmd BufNewFile,BufRead caseNotes.session :AutoSaveToggle
autocmd BufNewFile,BufRead scratchpad :AutoSaveToggle
" vim-bufferline repo
""Bundle 'bling/vim-bufferline'
" file-line repo
""Bundle 'bogado/file-line'
" auto-pairs repo
""Bundle 'jiangmiao/auto-pairs'
" colorizer repo; works outside of html/css
"Bundle 'lilydjwg/colorizer'
" coloresque repo; intended for html/css editing
"Bundle 'https://github.com/gorodinskiy/vim-coloresque.git'
" undotree repo
"Bundle 'mbbill/undotree'
nnoremap <F4> :UndotreeToggle<cr>

" Enable in-line man pages
runtime ftplugin/man.vim

" Set directory-wise configuration.
" Search from the directory the file is located upwards to the root for
" a local configuration file called .lvimrc and sources it.
"
" The local configuration file is expected to have commands affecting
" only the current buffer.

function SetLocalOptions(fname)
    let dirname = fnamemodify(a:fname, ":p:h")
    while "/" != dirname
        let lvimrc  = dirname . "/.lvimrc"
        if filereadable(lvimrc)
            execute "source " . lvimrc
            break
        endif
        let dirname = fnamemodify(dirname, ":p:h:h")
    endwhile
endfunction

au BufNewFile,BufRead * call SetLocalOptions(bufname("%"))

" GVim
set guioptions-=T " Disables toolbar
