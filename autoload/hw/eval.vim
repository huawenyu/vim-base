" https://gist.github.com/c9s/270195
if !exists("s:init")
    let s:init = 1
    silent! let s:log = logger#getLogger(expand('<sfile>:t'))
endif


fun! s:trim(val)
    if match(a:val, "|$") < 0
        return trim(a:val, '"\t ', 1)
    else
        return ''
    endif
endf


" Pre-process:
" - Skip the line endwith '|'
" - Help remove the comment ["']
" Mode: line, block, select
" - line
"   - firstly, try mode-block (~200 lines)      "@evalStart  ~  @evailEnd
"   - then backto line mode if fail
" - select
" Example:
"   'echo match("hello|", "|$")|
fun! hw#eval#repl(mode)
    let l:__func__ = "hw#eval#repl() "

    silent! call s:log.info(l:__func__, '>>>>>>>>>>>>>>>>>>>>>>')
    let mode = 'unknown'
    "echo search('\<if\|\(else\)\|\(endif\)', 'ncpe')
    if a:mode is# 'n'
        let lines = []

        let c_linenum = line('.')
        let start = search('@evalStart', 'ncbW', max([c_linenum - 100, 0]))
        let end = 0
        if start > 0
            let end = search('@evalEnd', 'ncW', min([c_linenum + 100, line('$')]))
        endif
        silent! call s:log.info(l:__func__, 'line='. line. ' start='. start, ' end='. end)
        if start > 0 && end > 0
            let mode = "block"
            let lines = getline(start+1, end-1)
        else
            let mode = "line"
            let text = getline('.')
            call add(lines, s:trim(text))
        endif
    elseif a:mode is# 'v'
        let mode = "select"
        "let lines = getline(a:s, a:e)
        let lines = hw#misc#GetSelection('lines')
    endif

    if has('lambda')
        let new_lines = map(copy(lines), {pos,val -> s:trim(val)})
    else
        echomsg l:__func__. 'feature lambda not available'
        return
    endif

    silent! call s:log.info(l:__func__, 'mode='. mode)
    silent! call s:log.info(l:__func__, new_lines)
    silent! call s:log.info(l:__func__, '<<<<<<<<<<<<<<<<<<<<<<<<')

    let file = tempname()
    cal writefile(new_lines, file)
    redir @e
    silent exec ':source '. file
    cal delete(file)
    redraw
    redir END
    echo "Region evaluated."

    if strlen(getreg('e')) > 0
        10new
        redraw
        silent file "EvalResult"
        setlocal noswapfile filetype=help buftype=nofile bufhidden=wipe
        setlocal nobuflisted nowrap cursorline nonumber fdc=0
        " syntax init
        set filetype="eval"
        syn match ErrorLine +^E\d\+:.*$+
        hi link ErrorLine Error
        silent $put =@e
    endif
endf

"augroup VimEval
"  au!
"  au filetype vim :command! -range Eval  :cal hw#eval#repl(<line1>,<line2>)
"  "au filetype vim :vnoremap <silent> e   :Eval<CR>
"augroup END
"
