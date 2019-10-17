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

" vim:set ft=vim et sw=2:
