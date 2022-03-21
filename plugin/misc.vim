if exists('g:loaded_basic_misc') || &cp
    finish
endif
let g:loaded_basic_misc = 1

" Don't know why but the behaviour is not correct
xnoremap <expr> <Plug>(EvalVim)     hw#eval#repl()
nnoremap <expr> <Plug>(EvalVim)     hw#eval#repl()
nnoremap <expr> <Plug>(EvalVimLine) hw#eval#repl() . '_'

" example mappings
"   xmap <leader>v <Plug>(EvalVim)
"   nmap <leader>v <Plug>(EvalVim)
"   omap <leader>v <Plug>(EvalVim)
"   nmap <leader>vv <Plug>(EvalVimLine)


"autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufEnter * if &buftype == 'terminal' | silent! normal A | endif
autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal A | endif


command! -nargs=* Wrap set wrap linebreak nolist
"command! -nargs=* Wrap PencilSoft
command! -nargs=* Copy set signcolumn=no nolist

""command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
"command! -nargs=+ -bang -complete=shellcmd
"      \ NeoMake execute ':NeomakeCmd make '. <q-args>

command! -nargs=1 Silent
  \ | execute ':silent !'.<q-args>
  \ | execute ':redraw!'

command! -nargs=* C0  setlocal autoindent cindent expandtab   tabstop=4 shiftwidth=4 softtabstop=4
command! -nargs=* C08 setlocal autoindent cindent expandtab   tabstop=8 shiftwidth=2 softtabstop=8
command! -nargs=* C2  setlocal autoindent cindent expandtab   tabstop=2 shiftwidth=2 softtabstop=2
command! -nargs=* C4  setlocal autoindent cindent noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
command! -nargs=* C8  setlocal autoindent cindent noexpandtab tabstop=8 shiftwidth=8 softtabstop=8

