" tasklist.vim
" @Author:      Huawen Yu
" @Created:     2019-12-30.
" @Last Change: 2019-12-30.
" @Revision:    0.1

if !exists("s:init")
    let s:init = 1
    silent! let s:log = logger#getLogger(expand('<sfile>:t'))

    let s:_tasks = []
    let s:_timer = v:null
endif

function! hw#tasklist#add(Function) abort
    call add(s:_tasks, a:Function)

    if s:_timer == v:null
        let s:_timer = timer_start(50, function('s:_run'))
    elseif empty(timer_info(s:_timer))
        let s:_timer = timer_start(50, function('s:_run'))
    endif
endf


function! s:_run(timer) abort
    for aFunctor in s:_tasks
        call aFunctor.do()
    endfor

    let s:_tasks = []
endf

