let perl_fold = 1
let foldlevel = 1
let perl_include_pod = 1
let perl_extended_vars = 1
set foldmethod=syntax
map <F8> :w \|:!perl -c % <CR>
map <F5> :w \|!% <CR>
nnoremap <leader>t :%!perltidy <CR>
vnoremap <leader>t :!perltidy <CR>
