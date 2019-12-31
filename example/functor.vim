silent! let s:log = logger#getLogger(expand('<sfile>:t'))

let myfunc = hw#functor#new({a, b -> execute('echo "Output2: " . a. " sec=". b', '')}, "hello world")
silent! call s:log.debug("test=", myfunc)
call myfunc.do("wilson", "good")
"
" [Output]
" [09:39:06][DEBUG][functor.vim] test={'__functor': {'do': function('<lambda>3')}, '__value': hello world, 'do': function('<SNR>319___curry_stub')}
" Output2: hello world sec=wilson

