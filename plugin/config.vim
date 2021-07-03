" Version:      1.2
" https://github.com/spf13/spf13-vim
" https://github.com/skywind3000/vim-init

if exists('g:loaded_local_basic') || &compatible
  finish
else
  let g:loaded_local_basic = 'yes'
endif

"if has("nvim")
"    let base16colorspace=256
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=0
"    set synmaxcol=2048
"else
"    set term=xterm-256color
"endif

set guifont=Liberation\ Mono\ 13
scriptencoding utf-8

set formatoptions+=m
set formatoptions+=B
set ffs=unix,dos,mac

if exists("g:vim_confi_option") && g:vim_confi_option.view_folding
    if has('folding')
        set foldenable
        set fdm=indent
        set foldlevel=99
    endif
endif

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
set ttyfast     | " u got a fast terminal
set lazyredraw  | " to avoid scrolling problems
"set autoread
set bs=eol,start,indent     | " set backspace pass another line

set showmatch
set matchtime=2     | " set match's seconds

set showmode
set linespace=0
set winminheight=0

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

if HasPlug('holokai')
    "set t_Co=256
    set background=dark
    silent! colorscheme holokai     | "Come from Plug 'vim-scripts/holokai'
endif

if HasPlug('seoul256.vim')
    "set t_Co=256
    " seoul256 (dark):
    "   Range:   233 (darkest) ~ 239 (lightest)
    "   Default: 237
    let g:seoul256_background = 236
    set background=dark
    silent! colorscheme seoul256

    let g:seoul256_srgb = 1    | " urxvt

    "colo seoul256-light
    "set background=light

    "When loaded, soul256.vim will set up two global variables so that you can use them to customize other plugins:
    " g:seoul256_current_fg - Current foreground color in ANSI code
    " g:seoul256_current_bg - Current background color in ANSI code
endif

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

set winaltkeys=no   " Vim will use Alt, so disable windows ALT trigger menu

set ignorecase
set smartcase
set hlsearch
set incsearch

if &history < 1000
    set history=1000
endif
if &undolevels < 1000
    set undolevels=1000
endif

if has('multi_byte')
    set encoding=utf-8      " set inner code
    "set fileencoding=utf-8  " set file default encode
    set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1      " open file decode orders
endif

"set shortmess+=a
"set shortmess=atI
"set shortmess-=oO
"set shortmess=aoOtTI
set shortmess+=filmnrxoOtT  " Abbrev. of messages (avoids 'hit enter')
"set paste           " conflict with auto-pairs, delimitmate, auto-close plugin
"set showcmd
set cmdheight=2    " fix: Vim asks me 'Press Enter or type command to continue' at startup.
set splitbelow
set splitright
set list

if exists("g:vim_confi_option") && g:vim_confi_option.auto_chdir
    set autochdir       " if work with shell or cscope, please not change work-dir
else
    set noautochdir
end

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

if exists("g:vim_confi_option") && g:vim_confi_option.show_number
    set number
else
    set nonumber
endif

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

"set iskeyword-=.                    " '.' is an end of word designator
"set iskeyword-=#                    " '#' is an end of word designator
"set iskeyword-=-                    " '-' is an end of word designator

set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignorecase
" vimgrep ignore
set wildignore+=*.so,*.swp,*.zip,*/vendor/*,*/\.git/*,*/\.svn/*,objd/**,obj/**,*/tmp/*,*.tmp
set wildignore+=*.o,*.obj,.hg,*.pyc,.git,*.rej,*.orig,*.gcno,*.rbc,*.class,.svn,coverage/*,vendor
set wildignore+=*.gif,*.png,*.map
set wildignore+=*.d
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android


" vim:set ft=vim et sw=4:
