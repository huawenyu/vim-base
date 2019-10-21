" Version:      1.2

if exists('g:loaded_mybasic') || &compatible
  finish
else
  let g:loaded_mybasic = 'yes'
endif

"if has("nvim")
"  let base16colorspace=256
"  let $NVIM_TUI_ENABLE_TRUE_COLOR=0
"  set synmaxcol=2048
"else
"  set term=xterm-256color
"endif

set nocompatible
set guifont=Liberation\ Mono\ 13

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Disable any use of bold fonts
set t_md=
set t_vb=
set hidden
set ttyfast  " u got a fast terminal
set lazyredraw " to avoid scrolling problems
"set autoread


" Vim status bar prediction/completion
"set wildmode=longest,list,full
set wildmode=longest:full,full
set wildmenu

" syntax enable
syntax on
" Vim slow reading very long lines
set synmaxcol=200
syntax on
set synmaxcol=200

"set t_Co=256
set background=dark
colorscheme holokai
"
"colorscheme badwolf
"colorscheme distinguished
"colorscheme darkspectrum
"colorscheme molokai
"colorscheme jellybeans
"colorscheme dracula
"
"let g:gruvbox_italic=1
"let g:gruvbox_termcolors=16
"let g:gruvbox_contrast_dark='hard'
"colorscheme gruvbox
"
"set background=light
"colorscheme PaperColor
"
"set background=light
"colo seoul256-light


if has('mouse')
  set mouse=a
  set mousefocus
endif
set foldmethod=manual

" C indent {
"set smartindent
"set cindent
"set cinoptions=:0,l1,t0,g0,(0
"}

set ignorecase
set smartcase
set hlsearch
set incsearch

set history=1000
set undolevels=1000

"set shortmess+=a
"set shortmess=atI
"set shortmess-=oO
set shortmess=aoOtTI
"set paste           " conflict with auto-pairs, delimitmate, auto-close plugin
"set showcmd
set cmdheight=2    " fix: Vim asks me 'Press Enter or type command to continue' at startup.
set splitbelow
set splitright
set list

"set autochdir       " if work with shell or cscope, please not change work-dir
set sessionoptions-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
set ssop+=curdir     " do not store absolute path
set ssop-=sesdir     " work under current dir as relative path

set visualbell
set noerrorbells
set nowrap
set nobackup
set noswapfile
set nowritebackup
set noshowmode
set nomodeline
set nowrapscan
set showbreak=↪ |"⇇
set noshowmatch
set nonumber

" Stay in same column while navigating up and down
"set virtualedit=all    | " shouldn't set, for it disable the left move when in start-of-line
set nostartofline

" Check which script change the config value
"   :verbose set tabstop sw softtabstop expandtab ?
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=180
set noexpandtab


set wildignorecase
" which will cause vimgrep ignore
set wildignore+=*.so,*.swp,*.zip,*/vendor/*,*/\.git/*,*/\.svn/*,objd/**,obj/**,*.tmp
set wildignore+=*.o,*.obj,.hg,*.pyc,.git,*.rej,*.orig,*.gcno,*.rbc,*.class,.svn,coverage/*,vendor
set wildignore+=*.gif,*.png,*.map
set wildignore+=*.d

" viminfo {{{2}}}
 " Tell vim to remember certain things when we exit
 "  !    :  The uppercase global VARIABLE will saved
 "  '30  :  marks will be remembered for up to 10 previously edited files
 "  "300 :  will save up to 100 lines for each register
 "  :30  :  up to 20 lines of command-line history will be remembered
 "  %    :  saves and restores the buffer list
 "  n... :  where to save the viminfo files,
 "            here save to /tmp means we have another viminfo manager 'workspace'
if has("nvim")
  set viminfo=!,'30,\"30,:30,%,n~/.nviminfo
else
  "set viminfo=!,'30,\"300,:30,%,n/tmp/viminfo
  set viminfo='30,\"30,:30,n~/.viminfo
endif


hi CursorLine guibg=Grey40
"hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi Visual term=reverse cterm=reverse guibg=Grey

"hi MatchParen cterm=bold ctermfg=cyan
"hi MatchParen cterm=none ctermbg=green ctermfg=none
"hi MatchParen cterm=none ctermbg=green ctermfg=blue
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" change highlight color for search hits
"hi Search guibg=peru guifg=wheat
"hi Search ctermfg=grey ctermbg=darkblue cterm=NONE
hi Search ctermfg=Red ctermbg=NONE cterm=NONE

"hi TabLineFill ctermfg=Black ctermbg=Green cterm=NONE
hi TabLine ctermfg=DarkBlue ctermbg=NONE cterm=NONE
hi TabLineSel ctermfg=Red ctermbg=NONE cterm=NONE
hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE

"hi NonText ctermfg=7 guifg=Gray
hi NonText ctermfg=DarkGrey guifg=DarkGrey
hi clear SpecialKey
hi link SpecialKey NonText

" The characters after tab is U+2002. in vim with Ctrl-v u 2 0 0 2 (in insert mode).
set listchars=tab:»\ ,trail:~,extends:<,nbsp:.
"set listchars=nbsp:.,tab:>-,trail:~,extends:>,precedes:<
"set listchars=tab:>.,trail:~,extends:<,nbsp:.
"set listchars=tab:> ,trail:~,extends:<,nbsp:.

set grepprg=grep

" tracelog
let g:tracelog_default_dir = $HOME . "/script/trace-wad/"

" Key maps {{{1
    " Bother when termopen and input space cause a little pause-stop-wait
    "let mapleader = "\<Space>"
    " Bother when in select-mode and use the leader not works, so also provide another leader
    " Space can be a bit tricky. Why not just map space to <leader>
    let mapleader = ","
    nmap <space> <leader>

    " diable Ex mode
    map Q <Nop>

    "" Stop that stupid window from popping up
    "map q: :q
    nmap ql :ls<cr>
    nmap qw :R! ~/tools/dict <C-R>=expand('<cword>') <cr>

    "" Disable F1 built-in help key by: re-replace last search
    "map <F1> :<c-u>%s///gc<cr>
    "imap <F1> :<c-u>%s//<C-R>0/gc<cr>

    " map <leader><Esc> :AnsiEsc<cr>
    nnoremap <C-c> <silent> <C-c>
    nnoremap <buffer> <Enter> <C-W><Enter>
    nnoremap <C-q> :<c-u>qa!<cr>

    nnoremap <C-s> :ToggleWorkspace<cr>
    " restore-session: vim -S
    "nnoremap <C-s> :Obsess
    "nnoremap <C-s> :Savews<cr>

    inoremap <S-Tab> <C-V><Tab>

    if exists('g:loaded_accelerated')
        " Accelerated_jk
        " when wrap, move by virtual row
        "let g:accelerated_jk_enable_deceleration = 1
        let g:accelerated_jk_acceleration_table = [1,2,3]

        nmap j <Plug>(accelerated_jk_gj)
        nmap k <Plug>(accelerated_jk_gk)
        "nmap j <Plug>(accelerated_jk_gj_position)
        "nmap k <Plug>(accelerated_jk_gk_position)
    else
        nnoremap j gj
        nnoremap k gk
    endif


    " vp doesn't replace paste buffer
    function! RestoreRegister()
        let @" = s:restore_reg
        let @+ = s:restore_reg | " sometime other plug use this register as paste-buffer
        return ''
    endfunction
    function! s:Repl()
        let s:restore_reg = @"
        return "p@=RestoreRegister()\<cr>"
    endfunction
    vnoremap <silent> <expr> p <sid>Repl()

    nnoremap <silent> <a-o> <C-o>
    nnoremap <silent> <a-i> <C-i>


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

    if has("nvim")
        let b:terminal_scrollback_buffer_size = 2000
        let g:terminal_scrollback_buffer_size = 2000

        " i: enter interact-mode, 'esc' exit interact-mode and enter vi-mode
        " But so far conflict with gdb mode
        "tnoremap <Esc> <C-\><C-n>
        tnoremap <leader>h <C-\><C-n><c-w>h
        tnoremap <leader>j <C-\><C-n><c-w>j
        tnoremap <leader>k <C-\><C-n><c-w>k
        tnoremap <leader>l <C-\><C-n><c-w>l

        tnoremap <c-h> <C-\><C-n><C-w>h
        tnoremap <c-j> <C-\><C-n><C-w>j
        tnoremap <c-k> <C-\><C-n><C-w>k
        tnoremap <c-l> <C-\><C-n><C-w>l
    endif

    " Automatically jump to end of text you pasted
    "vnoremap <silent> y y`]
    vnoremap <silent> p p`]
    nnoremap <silent> p p`]
    " Paste in insert mode
    inoremap <silent> <a-p> <c-r>"

    "nnoremap <silent> <a-n> :lnext<cr>
    "nnoremap <silent> <a-p> :lpre<cr>
    nnoremap <silent> <c-n> :cn<cr>
    nnoremap <silent> <c-p> :cp<cr>

    nnoremap <silent> <leader>n :cn<cr>
    nnoremap <silent> <leader>p :cp<cr>

"}}}

" vim:set ft=vim et sw=4:
