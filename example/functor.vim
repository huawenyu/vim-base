silent! let s:log = logger#getLogger(expand('<sfile>:t'))

let myfunc = hw#functor#new({a, b -> execute('echo "Output2: " . a. " sec=". b', '')}, "hello world")
silent! call s:log.debug("test=", myfunc)
call myfunc.do("wilson", "good")


