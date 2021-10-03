if !exists("s:init")
    let s:init = 1
    silent! let s:log = logger#getLogger(expand('<sfile>:t'))
endif


if exists('*strcharpart')
    function! hw#misc#Strcharpart(...) abort "{{{3
        return call(function('strcharpart'), a:000)
    endf
else
    function! hw#misc#Strcharpart(...) abort "{{{3
        return call(function('strpart'), a:000)
    endf
endif

" :display: tlib#selection#GetSelection(mode, ?mbeg="'<", ?mend="'>", ?opmode='selection')
" mode can be one of: selection, lines, block
function! hw#misc#GetSelection(mode, ...) range
    let l:__func__ = "hw#misc#GetSelection() "

    if a:0 >= 2
        let mbeg = a:1
        let mend = a:2
    else
        let mbeg = "'<"
        let mend = "'>"
    endif
    let opmode = a:0 >= 3 ? a:3 : 'selection'
    let l0   = line(mbeg)
    let l1   = line(mend)
    let text = getline(l0, l1)
    let c0   = col(mbeg)
    let c1   = col(mend)

    silent! call s:log.info(l:__func__, "beg=", mbeg, " end=", mend, " mode=", opmode, " l0=", l0, " l1=", l1, " c0=", c0, " c1=", c1)
    silent! call s:log.info(l:__func__, "len=", len(text[-1]), " ", text[-1])

    if opmode == 'block'
        let clen = c1 - c0
        call map(text, 'hw#misc#Strcharpart(v:val, c0, clen)')
    elseif opmode == 'selection'
        if c1 > 1
            "let text[-1] = hw#misc#Strcharpart(text[-1], 0, c1 - (a:mode == 'o' || c1 > len(text[-1]) ? 0 : 1))
            let text[-1] = hw#misc#Strcharpart(text[-1], 0, c1)
        endif
        if c0 > 1
            let text[0] = hw#misc#Strcharpart(text[0], c0 - 1)
        endif
    endif
    return text
endfunction


" @param mode: 'n' normal, 'v' selection
function! hw#misc#GetWord(mode)
    if a:mode is# 'n'
        let sel_str = expand('<cword>')
    elseif a:mode is# 'v'
        let sel_str = hw#misc#GetSelection('')
        if empty(sel_str)
            let sel_str = expand('<cword>')
        else
            let sel_str = sel_str[0]
            if empty(sel_str)
                let sel_str = expand('<cword>')
            endif
        endif
    endif

    return sel_str
endfunction


" Example:
" let your_saved_mappings = Save_mappings(['<C-a>', '<C-b>', '<C-c>'], 'n', 1)
" ...
" call Restore_mappings(your_saved_mappings)
"
fu! hw#misc#SaveMaps(keys, mode, global) abort
    let mappings = {}

    if a:global
        for l:key in a:keys
            let buf_local_map = maparg(l:key, a:mode, 0, 1)

            sil! exe a:mode.'unmap <buffer> '.l:key

            let map_info        = maparg(l:key, a:mode, 0, 1)
            let mappings[l:key] = !empty(map_info)
                                \     ? map_info
                                \     : {
                                        \ 'unmapped' : 1,
                                        \ 'buffer'   : 0,
                                        \ 'lhs'      : l:key,
                                        \ 'mode'     : a:mode,
                                        \ }

            call hw#misc#RestoreMaps({l:key : buf_local_map})
        endfor

    else
        for l:key in a:keys
            let map_info        = maparg(l:key, a:mode, 0, 1)
            let mappings[l:key] = !empty(map_info)
                                \     ? map_info
                                \     : {
                                        \ 'unmapped' : 1,
                                        \ 'buffer'   : 1,
                                        \ 'lhs'      : l:key,
                                        \ 'mode'     : a:mode,
                                        \ }
        endfor
    endif

    return mappings
endfu


fu! hw#misc#RestoreMaps(mappings) abort

    for mapping in values(a:mappings)
        if !has_key(mapping, 'unmapped') && !empty(mapping)
            exe     mapping.mode
               \ . (mapping.noremap ? 'noremap   ' : 'map ')
               \ . (mapping.buffer  ? ' <buffer> ' : '')
               \ . (mapping.expr    ? ' <expr>   ' : '')
               \ . (mapping.nowait  ? ' <nowait> ' : '')
               \ . (mapping.silent  ? ' <silent> ' : '')
               \ .  mapping.lhs
               \ . ' '
               \ . substitute(mapping.rhs, '<SID>', '<SNR>'.mapping.sid.'_', 'g')

        elseif has_key(mapping, 'unmapped')
            sil! exe mapping.mode.'unmap '
                                \ .(mapping.buffer ? ' <buffer> ' : '')
                                \ . mapping.lhs
        endif
    endfor
endfu


if HasPlug('vim-floaterm') | " {{{1
fu! hw#misc#Execute(sel_mode, cmd) abort
    if len(a:cmd) == 0 | return | endif

    silent execute ':FloatermKill! hwcmd'

    let sel_str = hw#misc#GetWord(a:sel_mode)
    if len(sel_str) > 0
        let l:args = input(a:cmd. "  ", sel_str)
        let l:command=':FloatermNew --name=hwcmd --position=bottom --autoclose=0 --height=0.4 --width=0.7 --title='. a:cmd
        let l:command= l:command. printf(" %s %s", a:cmd, l:args)
        silent execute l:command
        stopinsert
    endif
endfu
endif


