if exists('g:loaded_hw_basic_map') || &compatible
  finish
endif
let g:loaded_hw_basic_map = 1

if g:vim_confi_option.upper_keyfixes
    if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif
    "cmap Tabe tabe
endif

if g:vim_confi_option.enable_map_basic
    " https://vimways.org/2018/for-mappings-and-a-tutorial/
    "" Stop that stupid window from popping up
    "map q: :q

    "" Disable F1 built-in help key by: re-replace last search
    "map <F1> :<c-u>%s///gc<cr>
    map <F1> :<c-u>%s//<C-R>"/gc<cr>

    " map <leader><Esc> :AnsiEsc<cr>
    nnoremap <C-c> <silent> <C-c>
    "nnoremap <buffer> <Enter> <C-W><Enter>     | " vimwiki use this to create a new link

    " Ctrl-q: if-window exit all, if-terminal exit terminal
    nnoremap <C-q> :<c-u>qa!<cr>
    nnoremap <leader>q :<c-u>qa<cr>

    "" Esc too far, use Ctrl+Enter as alternative
    "inoremap <a-CR> <Esc>
    "vnoremap <a-CR> <Esc>

    " Adjust viewports to the same size
    map <leader>= <C-w>=

    inoremap <S-Tab> <C-V><Tab>

    noremap  j gj
    vnoremap j gj
    noremap  k gk
    vnoremap k gk
    vnoremap > >gv
    vnoremap < <gv

    " " H/L - jump to start/end of line (^/$)
    " " J/K - jump down/up half a screen (C-d/C-u)
    " nnoremap H ^
    " nnoremap L $
    " nnoremap gj <C-d>
    " nnoremap gk <C-u>

    " https://www.reddit.com/r/vim/comments/53bpb4/alternatives_to_esc/
    " https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping
    " @ver1: using jj, but how about the select-mode, the 'j' as move
    "noremap   jj <Esc>
    "noremap!  jj <Esc>
    " @ver2: want input ';' at the end of current line, then exit by hit two ';;', which will auto remove the first wanted ';'
    "nnoremap ;; <Esc>
    "inoremap ;; <Esc>
    "vnoremap ;; <Esc>
    " @ver3: confuse it's insert mode or normal mode, or if enter multiple i
    "noremap   ii <Esc>
    "noremap!  ii <Esc>
    " @ver4:
    inoremap ,, <Esc>`^
    onoremap ,, <Esc>`^
    vnoremap ,, <Esc>`<
    cnoremap ,, <c-u><Esc>
    " @ver5: save & exit insert-mode
    "inoremap jj <c-o>:w<cr><ESC>
    " @ver6: save & exit insert-mode
    nnoremap <leader>w :w<cr><ESC>
    nnoremap <leader>ww :w<cr><ESC>

    " Save in insert mode, comment out it for anoy when you input the letter 'k'.
    "inoremap kk <c-o>:w<cr>

    "nnoremap <silent> ;ww :w!<cr>
    " Temporarily turns off search highlighting
    nnoremap <silent> <Return> :nohls<Return><Return>
    " Count the number of occurrences of the last search pattern
    nnoremap  ;#   :<c-u>%s///gn<cr>
    nnoremap  ;^   :<c-u>g//p<cr>
    nnoremap  ;*   :cexpr []<cr> <bar>:<c-u>g//caddexpr shellescape(expand("%")) . "|" . line(".") . "|" . getline(".")<cr> <bar>:copen<cr>

    " Lazy macro repeat
    nmap <leader>.  @@

endif

if g:vim_confi_option.enable_map_useful

    " https://stackoverflow.com/questions/18175647/jump-with-ctrl-i-doesnt-work-in-my-macvim-but-ctrl-o-works
    " Please don't map tab, since it's same as c-i, and will overwrite our c-i.
    ""Tab: Toggle folds
    "    "nnoremap <Tab> za
    "    nnoremap <Tab>   zR
    "    nnoremap <S-Tab> zM
    "? if c, map to file header/source
    "au FileType c,cpp nnoremap <silent> <Tab>  :call JumpToCorrespondingFile()<cr>
    au FileType c,cpp nnoremap <silent> <leader>fa  :call JumpToCorrespondingFile()<cr>

    " Jump to a file whose extension corresponds to the extension of the current
    " file. The `tags' file, created with:
    " $ ctags --extra=+f -R .
    " has to be present in the current directory.
    function! JumpToCorrespondingFile()
        let l:extensions = { 'c': 'h', 'h': 'c', 'cpp': 'hpp', 'hpp': 'cpp' }
        let l:fe = expand('%:e')
        if has_key(l:extensions, l:fe)
            execute ':tag ' . expand('%:t:r') . '.' . l:extensions[l:fe]
        endif
    endfunct


    " similar to gv, reselects the last changed block
    " highlight last inserted text
    nnoremap gV `[v`]

    " Anoy try to delete some character but format it not in insert mode
    " press <backspace> to switch to the "alternate file"
    "nnoremap <BS> <C-^>

    " Reformat whole file
    "nnoremap g= gg=G``

    " Move to beginning/end of line
    nnoremap B ^
    nnoremap E $

    map W <Plug>(expand_region_expand)
    map Q <Plug>(expand_region_shrink)


    augroup HwbasicFtMap
        autocmd!
        autocmd FileType help,man,floaterm     nnoremap <buffer> <C-[> :q<cr>
        autocmd FileType help,man,floaterm     nnoremap <buffer> q     :q<cr>
        autocmd FileType qf                    nnoremap <buffer> <c-o> :colder<cr>
        autocmd FileType qf                    nnoremap <buffer> <c-i> :cnewer<cr>
    augroup END


    " Finger candy: same-bind a-, c-, leader-
    " Alt+HJKL   move around tmux pane
    " Ctrl+HJKL  move around vim-window/tmux-pane
    "
    "" Move to HwbasicFtMap
    " nnoremap <silent> <a-o>   :colder<cr>
    " nnoremap <silent> <a-i>   :cnewer<cr>

    nnoremap <silent> <leader>o <C-o>
    nnoremap <silent> <leader>i <C-i>

    " lsp-goto declare
    "nnoremap <silent> <leader>; ;fd
    nnoremap <silent> <leader>; <C-]>
    "inoremap <silent> <leader>[ <C-[>

    " Take as map hole
    "nnoremap <silent> <leader>,,,

    " Substitue for MaboXterm diable <c-h>
    nnoremap <leader>h <c-w>h
    nnoremap <leader>j <c-w>j
    nnoremap <leader>k <c-w>k
    nnoremap <leader>l <c-w>l

    " Replace by vim-tmux-navigator
    "nnoremap <c-h> <c-w>h
    "nnoremap <c-j> <c-w>j
    "nnoremap <c-k> <c-w>k
    "nnoremap <c-l> <c-w>l

    " Go to end of parenthesis/brackets/quotes
    " <C-o> is used to issue a normal mode command without leaving insert mode.
    inoremap <C-e>      <C-o>A

    " Navigate quickfix
    nnoremap <silent> <c-n> :cn<cr>
    nnoremap <silent> <c-p> :cp<cr>

    " Navigate locallist
    nnoremap <silent> <leader>n :lne<cr>
    nnoremap <silent> <leader>p :lp<cr>


    " nvim.terminal map {{{2
    if has("nvim")
        let b:terminal_scrollback_buffer_size = 2000
        let g:terminal_scrollback_buffer_size = 2000

        " Terminal exit-to-text-mode, i: enter interact-mode
        " conflict with gdb mode
        "   tnoremap <Esc> <C-\><C-n>
        tnoremap <c-o>     <C-\><C-n>

        "tnoremap <leader>h <C-\><C-n><c-w>h
        "tnoremap <leader>j <C-\><C-n><c-w>j
        "tnoremap <leader>k <C-\><C-n><c-w>k
        "tnoremap <leader>l <C-\><C-n><c-w>l

        tnoremap <c-h> <C-\><C-n><C-w>h
        tnoremap <c-j> <C-\><C-n><C-w>j
        tnoremap <c-k> <C-\><C-n><C-w>k
        tnoremap <c-l> <C-\><C-n><C-w>l
    endif


    " Show current color's name: zS show syntax[vim-scriptease]
    nnoremap zC :echomsg synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<cr>
    nnoremap zc :echomsg synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")<cr>


    " Automatically jump to end of text you pasted
    "vnoremap <silent> y y`]
    vnoremap <silent> p p`]
    nnoremap <silent> p p`]

    " now it is possible to paste many times over selected text
    xnoremap <expr> p 'pgv"'.v:register.'y'

    " Paste in insert mode
    inoremap <silent> <a-i> <c-r>"
    Shortcut! <leader><a-i> Paste in insert mode


    nnoremap <leader>dt :%s/\s\+$//g
    nnoremap <leader>dd :g/<C-R><C-w>/ norm dd
    vnoremap <leader>dd :<c-u>g/<C-R>*/ norm dd

    " remove space from emptyline
    "nnoremap <leader>v<space> :%s/^\s\s*$//<CR>
    "vnoremap <leader>v<space> :s/^\s\s*$//<cr>

    " count the number of occurrences of a word
    "nnoremap <leader>vc :%s/<C-R>=expand('<cword>')<cr>//gn<cr>
    nnoremap <leader>vn :%s///gn<cr>
    Shortcut! <space>vn    Tool count

    " For global replace
    nnoremap <leader>vR gD:%s/<C-R>///g<left><left>
    "vnoremap <leader>vr ""y:%s/<C-R>=escape(@", '/\')<CR>/<C-R>=escape(@", '/\')<CR>/g<Left><Left>

endif
