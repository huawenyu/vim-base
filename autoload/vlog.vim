" Author: Nathan Farrar <nfarrar@crunk.io>
" Website: https://crunk.io/dotfiles/
" Description: vlog plugin {{{
"
"   A light weight message logging interface for debugging vim configurations.
"   Messages are saved to a list rather than a file to improve performance
"   times.
"
"   - Echo, echom and echoerr seem highly unreliable to me. Various plugins
"     call :redraw, which flushes messages and we never see them.
"
"   - It's not good practice to leave 'echo' commands sitting around in
"     plugins - depending on the user's configuration they force 'prompt here
"     to continue' messages, which makes the messages feature unusable for 
"     debugging output, imho.
"
"   TODO:
"
"   - log messages to a 'toggableable' buffer
"   - capture messages from echo, echom & echoerr?
"   - hook 'source' commands and inject debugging messages?
"
"   Bookmarks:
"
"   - https://stackoverflow.com/questions/2573021/how-to-redirect-ex-command-output-into-current-buffer-or-file
"   - https://github.com/mbbill/echofunc
"   - https://gist.github.com/mattn/715256
"   - http://cowsthatgomoo.blogspot.com/2014/12/how-to-echo-color-from-vim-using.html
"   - https://github.com/AD7six/vim-activity-log
"   - https://github.com/taku-o/vim-logging/blob/master/plugin/logging.vim
"
" }}}

let s:vlog_enable = 0

" List of log messages.
let s:vlog_messages = []

" Bind log level names to ints.
let s:vlog_levels = {
            \ 'ERROR': 4,
            \ 'WARN':  3,
            \ 'INFO':  2,
            \ 'DEBUG': 1
            \ }

" Set the default log level.
if ! empty($VIM_VLOG_LEVEL) && has_key(s:vlog_levels, $VIM_VLOG_LEVEL)
    let s:vlog_level = $VIM_VLOG_LEVEL
else
    let s:vlog_level = 'DEBUG'
endif

function! s:timestamp() " {{{
    return strftime("%Y.%m.%d_%H:%M:%S")
endfunction " }}}

function! s:vlog(msg, msg_lvl) " {{{
    if s:vlog_enable && a:msg_lvl >= s:vlog_levels[s:vlog_level]
        call add(s:vlog_messages, s:timestamp() . ' ' . a:msg)
    endif
endfunction " }}}

function s:vlog_echo(msg) " {{{
    " execute! printf '\x1b[31m;%s;[x1b\0m' 
    " echo printf("\x1b[31m%s[\x1b[0m", a:msg)
    echomsg a:msg
endfunction " }}}

function! vlog#error(msg) " {{{
    call s:vlog(a:msg, s:vlog_levels.ERROR)
endfunction " }}}

function! vlog#warn(msg) " {{{
    call s:vlog(a:msg, s:vlog_levels.WARN)
endfunction " }}}

function! vlog#info(msg) " {{{
    call s:vlog(a:msg, s:vlog_levels.INFO)
endfunction " }}}

function! vlog#debug(msg) " {{{
    call s:vlog(a:msg, s:vlog_levels.DEBUG)
endfunction " }}}

function! vlog#display() " {{{
    for msg in s:vlog_messages
        call s:vlog_echo(msg)
    endfor
endfunction " }}}

function! vlog#clear() " {{{
    let s:vlog_messages = []
    call vlog#info("===[Output of vlog]:===")
endfunction " }}}

function! vlog#toggle(...) " {{{
    if a:0 > 0
        let s:vlog_enable = a:1
    else
        let s:vlog_enable = !s:vlog_enable
    endif
endfunction " }}}

call vlog#info("===[Output of vlog]:===")

