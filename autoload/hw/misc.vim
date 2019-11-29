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
    " TLogVAR mbeg, mend, opmode, l0, l1, c0, c1
    " TLogVAR text[-1]
    " TLogVAR len(text[-1])
    if opmode == 'block'
        let clen = c1 - c0
        call map(text, 'hw#misc#Strcharpart(v:val, c0, clen)')
    elseif opmode == 'selection'
        if c1 > 1
            let text[-1] = hw#misc#Strcharpart(text[-1], 0, c1 - (a:mode == 'o' || c1 > len(text[-1]) ? 0 : 1))
        endif
        if c0 > 1
            let text[0] = hw#misc#Strcharpart(text[0], c0 - 1)
        endif
    endif
    return text
endf

