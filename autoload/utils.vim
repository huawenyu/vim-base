function! utils#IsLeftMostWindow()
    let curNr = winnr()
    wincmd h
    if winnr() == curNr
        return 1
    endif
    wincmd p " Move back.
    return 0
endfunction

" Refresh files
function! utils#RefreshWindows()
    call genutils#MarkActiveWindow()
    let act_tabnr = tabpagenr()
    let counts = 0

    for tab_nr in range(1, tabpagenr('$'))
        silent! exec tab_nr . "tabnext"

        let act_nr = winnr()
        for nr in range(1, winnr('$'))
            silent! exec nr . "wincmd w"
            if getwinvar(1, "&modifiable") == 1
                silent! e!
                let counts += 1
            endif
        endfor
        silent! exec act_nr . "wincmd w"
    endfor

    silent! exec act_tabnr . "tabnext"
    call genutils#RestoreActiveWindow()
    echom "Reload " . counts . " times!"
endfunction


function! utils#Columnline()
    let l:col = col('.')
    let l:virtcol = virtcol('.')

    "echom "current: " . l:col . strtrans(getline(".")[col(".")-2])

    " Show colorcolumn
    if l:col == 1
                \ ||strtrans(getline(".")[col(".")-1]) == ' '
                \ || strtrans(getline(".")[col(".")-1]) == "^I"
                \ || strtrans(getline(".")[col(".")-2]) == ' '
                \ || strtrans(getline(".")[col(".")-2]) == "^I"
        if l:col == 1 || &colorcolumn == l:virtcol
            setlocal colorcolumn&
            unlet! g:colorcolumn_col
        else
            let &l:colorcolumn = l:virtcol
            let g:colorcolumn_col = l:col
        endif
    endif
endfunction


function! utils#VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction


" preconditon: mark a, mark b
" then in <gdb> source log.crash
function! utils#Tracecrash()
    exec ":silent %normal \<ESC>0i#"
    exec ":'u,'n normal df["
    exec ":'u,'n normal f]d$"
    exec ":'u,'n normal Il *"
endfunction

function! utils#VoomInsert(vsel)
    let number = 1
    if v:count > 0
        let number = v:count
    endif

    let perc = line('.') * 1000 / line('$')
    if a:vsel
        let temp = @s
        norm! gv"sy
        let line_ins = "#" . perc ."% ". @s . " {{{" . "" . number . "}}}"
        let @s = temp
    else
        let line_ins = "#" . perc ."% ". expand('<cword>') . " {{{" . "" . number . "}}}"
    endif

    norm O
    let len = len(line_ins)
    execute "put =line_ins"
    call cursor(line('.'), len - 3)
endfunction

function! utils#GetFileFrmCursor()
    " filename under the cursor
    let file_name = expand('<cfile>')
    if !strlen(file_name)
        echo 'No file under cursor.'
        return
    endif

    " Remove git prefix 'a/', 'b/' from filepath
    if !filereadable(file_name)
        let file_name = trim(file_name, "a/")
    endif
    if !filereadable(file_name)
        let file_name = trim(file_name, "b/")
    endif

    " look for a line number separated by a :
    let line_number = ""
    let save_pos = getpos(".")
    if search('\%#\f*:\zs[0-9]\+')
        " change the 'iskeyword' option temporarily to pick up just numbers
        let temp = &iskeyword
        set iskeyword=48-57
        let line_number = "+". expand('<cword>')
        exe 'set iskeyword=' . temp
    endif
    call setpos('.', save_pos)

    return [file_name, line_number]
endfunction


function! utils#GotoFileWithLineNum(newwin)
    let file_info = utils#GetFileFrmCursor()
    " Open new window if requested
    if a:newwin
        new
    endif

    " https://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser
    " gnome-open/xdg-open
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
    if s:uri != ""
        if exists(":W3mTab")
            exec "W3mTab "..s:uri
        else
            echo "Please install vim-plug `w3m.vim` and command `w3m`."
        endif
    else
        execute 'find ' . file_info[1] . ' ' . file_info[0]
    endif
endfunction


" open file in previewwindow
function! utils#GotoFileWithPreview()
    call genutils#MarkActiveWindow()
    let file_info = utils#GetFileFrmCursor()
    if len(file_info) == 0
        echo 'No file under cursor.'
        return
    endif

    let l:act_nr = winnr()
    let l:have_preview = 0
    let l:preview_nr = 0
    let t:x=[]
    windo call add(t:x, winnr())
    for i in t:x
        if getwinvar(i, '&previewwindow')
            let l:have_preview = 1
            let l:preview_nr = i
            break
        endif
    endfor

    if !l:have_preview
        call genutils#RestoreActiveWindow()

        wincmd l " Move right side.
        let l:preview_nr = winnr()

        "if l:preview_nr != l:act_nr
        "    let &l:previewwindow = 1
        "endif
    endif

    if l:preview_nr > 0
        call genutils#MoveCursorToWindow(l:preview_nr)
        execute 'find ' . file_info[1] . ' ' . file_info[0]
    else
        let winnr = genutils#GetPreviewWinnr()
        if winnr > 0
            call genutils#MoveCursorToWindow(winnr)
            execute 'find ' . file_info[1] . ' ' . file_info[0]
        endif
    endif

    call genutils#RestoreActiveWindow()
endfunction

" Get current word or selected-range
" @param fname Write to the file, if no <fname>, return the string
function! utils#GetSelected(mode, ...)
    if a:0 > 0
        let fname = a:1
    else
        let fname = ''
    end

    if empty(a:mode)
        let mode = visualmode()
        if empty(mode)
            let mode = 'n'
        else
            let mode = 'v'
        endif
    else
        let mode = a:mode
    endif

    if mode ==# 'n'
        let ret_str = expand('<cword>')
    elseif mode ==# 'v'
        " Why is this not a built-in Vim script function?!
        let [lnum1, col1] = getpos("'<")[1:2]
        let [lnum2, col2] = getpos("'>")[1:2]
        if lnum1 == lnum2
            let curline = getline('.')
            let ret_str = curline[col1-1:col2-1]
        else
            let lines = getline(lnum1, lnum2)
            let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
            let lines[0] = lines[0][col1 - 1:]

            if empty(fname)
                let ret_str = join(lines, "\n")
            else
                call writefile(lines, fname)
                echomsg len(lines).." lines yanked to file"
                silent! norm gv
                return
            endif
        endif
    endif

    if empty(fname)
        return ret_str
    else
        call writefile(split(ret_str, "\n", 1), glob(fname))
    endif
endfunction

function! utils#MarkSelected(mode)
    if a:mode ==# 'v'
        let [lnum1, col1] = getpos("'<")[1:2]
        let [lnum2, col2] = getpos("'>")[1:2]
        if lnum1 != lnum2
            "let cursor = getpos('.')
            let byte1 = line2byte(lnum1)
            let byte2 = line2byte(lnum2)
            exec 'delmarks un'
            exec 'goto'. byte1 . '| norm mu'
            exec 'goto'. byte2 . '| norm mn'
            "call setpos('.', cursor)
        endif
    elseif a:mode ==# 'n'
        delm! | delm A-Z0-9
        call signature#sign#Refresh(1)
        redraw
    endif
endfunction

function! utils#AppendToFile(file, lines)
    call writefile(a:lines, a:file, "a")
endfunction
