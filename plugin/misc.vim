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

""command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
"command! -nargs=+ -bang -complete=shellcmd
"      \ NeoMake execute ':NeomakeCmd make '. <q-args>

command! -nargs=1 Silent
  \ | execute ':silent !'.<q-args>
  \ | execute ':redraw!'


