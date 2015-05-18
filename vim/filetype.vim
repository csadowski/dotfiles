if exists('did_load_filetypes')
    finish
endif
augroup filetypedetect
autocmd BufNewFile,BufRead *.ni    setf inform7
autocmd BufNewFile,BufRead *.ifm   setf ifm
augroup END
