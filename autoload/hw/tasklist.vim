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


" EXAMPLES: >
"   echo hw#list#Inject([1,2,3], 0, function('Add')
"   => 6
function! hw#tasklist#add(Function) abort
    call append(s:_tasks, Function)

    if s:_timer != v:null
        let s:_timer = timer_start(0, function('s:_publish', [a:promise]))
    elseif empty(timer_info(s:_timer))
        let s:_timer = timer_start(0, function('s:_publish', [a:promise]))
    endif
endf


" EXAMPLES: >
"   hw#list#Compact([0,1,2,3,[], {}, ""])
"   => [1,2,3]
function! hw#tasklist#TimerRun(list) abort
    call timer_start(0, function('s:_publish', [a:promise]))
endf


