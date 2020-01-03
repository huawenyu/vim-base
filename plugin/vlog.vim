if exists('g:loaded_vlog') || &cp
    finish
endif
let g:loaded_vlog = 1

" if has('autocmd')
"  augroup
"    autocmd!
"      autocmd SourcePre call vlog#debug('sourced file ' . a:file)
"  augroup END
" endif

" call vlog#debug('sourced '. expand('%:p')
" call vlog#debug('test')

command! -bar VlogDisplay :call vlog#display()
command! -bar VlogClear :call vlog#clear()
command! -bar VlogToggle :call vlog#toggle()

