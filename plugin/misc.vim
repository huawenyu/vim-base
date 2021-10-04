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
"
