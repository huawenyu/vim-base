if exists('g:loaded_basic_misc') || &cp
    finish
endif
let g:loaded_basic_misc = -1

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

fun! HWWrap_(bang)
    if a:bang
        set list nowrap nolinebreak
    else
        set wrap linebreak nolist
    endif
endfun

fun! HWCopy_(bang)
    if a:bang
        set signcolumn=yes list
        if exists(":LspStart")
            LspStart
        endif
    else
        set signcolumn=no nolist
        if exists(":LspStop")
            LspStop
        endif
    endif
endfun

command! -nargs=* -bang MyWrap call HWWrap_(<bang>0)
command! -nargs=* -bang MyCopy call HWCopy_(<bang>0)

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


" Copy from https://github.com/teto/vim-listchars {{{1
    "set listchars=tab:»\ ,trail:~,extends:<,nbsp:.

    let g:listchar_formats=[
       \"tab:»\\ ,trail:~,extends:<,nbsp:.",
       \"tab:..,space:.,trail:\\ ,extends:.,nbsp:.",
       \"tab:..,trail:\\ ,extends:.,nbsp:.",
       \"tab:--,space:-,trail:\\ ,extends:-,nbsp:-",
       \"tab:--,trail:\\ ,extends:-,nbsp:-",
       \"tab:»·,eol:↲,nbsp:␣,extends:…,space:␣,precedes:<,extends:>,conceal:┊,trail:░",
       \"tab:»·,eol:↲,nbsp:␣,extends:…,space:␣,precedes:☚,extends:☛,conceal:┊,trail:☠",
       \"tab:»…,space:.,nbsp:%,trail:␣"
       \]

    function! ToggleInvisibleChar()
       let l:len = len(g:listchar_formats)

       "set signcolumn=no
       let g:loaded_basic_misc += 1
       if g:loaded_basic_misc >= l:len
          set nolist
          let g:loaded_basic_misc = -1
       else
          set list
          execute "set listchars=".g:listchar_formats[g:loaded_basic_misc]
       endif
    endfunction

    " Set the default listchars 0
    call ToggleInvisibleChar()

    command! ToggleListchars call ToggleInvisibleChar()
    map <silent> <Plug>(ToggleListchars) :ToggleListchars<CR>
"}}}

