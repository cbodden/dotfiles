"Modeline and Notes {
"vim: set foldmarker={,} foldlevel=0 spell:
"}

"Basics {
    set nocompatible                " explicitly get out of vi-compatible mode
    set noexrc                      " don't use local version of .(g)vimrc, .exrc
    set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor
    "             ||||||||     between joined lines
    "             |||||||+-- When a new match is created (showmatch)
    "             |||||||     pause for .5
    "             ||||||+-- Set buffer options when entering the
    "             ||||||     buffer
    "             |||||+-- :write command updates current file name
    "             ||||+-- Automatically add <CR> to the last line
    "             ||||     when using :@r
    "             |||+-- Searching continues at the end of the match
    "             |||     at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    syntax on                       " syntax highlighting on
"}

"General {
    filetype plugin indent on       " load filetype plugins/indent settings
    set autochdir                   " always switch to the current file directory
    set autoread                    " auto read when a file is changed from the outside
    set backspace=indent,eol,start  " make backspace a more flexible
    set backup                      " make backup files
    set backupdir=~/.vim/backup     " where to put backup files
    set clipboard+=unnamed          " share windows clipboard
    set directory=~/.vim/tmp        " directory to place swap files in
    set fenc=utf-8                  " UTF-8
    set fileformats=unix,dos,mac    " support all three, in this order
    set hidden                      " you can change buffers without saving
    set history=1000                " how many lines of history VIM has to remember
    set iskeyword+=_,$,@,%,#        " none of these are word dividers
    set ml                          " set modelines
    set mouse=a                     " use mouse everywhere
    set noerrorbells                " don't make noise
    set pastetoggle=<F2>            " when insert mode, press f2 for paste mode
    " set spell                     " spell checking : http://tips.webdesign10.com/vim/how-use-vims-spellchecker
    set tags=~/.vim/tags/           " tag usage
    set timeoutlen=300 ttimeoutlen=0" mapping delays
    set undodir=~/.vim/undo         " persistent undo dir
    set undofile                    " persistent undo regardless of buffer unload
    set undolevels=1000             " many levels of undo
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " ignore these list file extensions
    set wildmenu                    " turn on command line completion wild style
    set wildmode=list:longest       " turn on wild mode huge list
    set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
"}

"Vim UI {
    "colorscheme dracula
    " colorscheme solarized
    set background=dark             " always keep background dark regardless of color theme
    set colorcolumn=80,120          " highlight maximum line length
    set cursorline                  " highlight current line
    set encoding=utf8               " Set utf8 as encoding and en_US as the language
    set hlsearch                    " highlight searched for phrases
    set incsearch                   " BUT do highlight as you type your search phrase
    set laststatus=2                " always show the status line
    set lazyredraw                  " do not redraw while running macros
    set linespace=0                 " don't insert any extra pixel lines betweens rows
    set list                        " we do what to show tabs, to ensure we get them out of my files
    set listchars=tab:>-,trail:-    " show tabs and trailing
    set matchtime=5                 " how many tenths of a second to blink matching brackets for
    set cursorcolumn                " don't highlight the current column
    set nostartofline               " leave my cursor where it was
    set novisualbell                " don't blink
    set number                      " turn on line numbers
    set numberwidth=5               " We are good up to 99999 lines
    set relativenumber              " show relative line number
    set report=0                    " tell us when anything is changed via :...
    set ruler                       " Always show current positions along the bottom
    set scrolloff=10                " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT             " shortens messages to avoid 'press a key' prompt
    set showcmd                     " show the command being typed
    set showmatch                   " show matching brackets
    set sidescrolloff=10            " Keep 5 lines at the size
    set t_Co=256                    " enables 256 colors
    " set termguicolors               " support for colorscheme in ST
    set title                       " change the terminals title
    "set statusline=%F%m%r%h%w\ [Lines:%L]\ [Type:%{&ff}]\ %y\ [%p%%]\ [%04l,%04v]\ [FoldLevel:%{foldlevel('.')}]
    ""              | | | | |          |          |        |    |       |    |                 |
    ""              | | | | |          |          |        |    |       |    |                 + current foldlevel
    ""              | | | | |          |          |        |    |       |    + current column
    ""              | | | | |          |          |        |    |       +-- current line
    ""              | | | | |          |          |        |    +-- current % into file
    ""              | | | | |          |          |        +-- current syntax in square brackets
    ""              | | | | |          |          +-- current fileformat
    ""              | | | | |          +-- number of lines
    ""              | | | | +-- preview flag in square brackets
    ""              | | | +-- help flag in square brackets
    ""              | | +-- readonly flag in square brackets
    ""              | +-- rodified flag in square brackets
    ""              +-- full path to file in the buffer
"}

"Text Formatting/Layout {
    set completeopt=                " don't use a pop up menu for completions
    set expandtab                   " no real tabs please!
    set formatoptions=rq            " Automatically insert comment leader on return, and let gq format comments
    set ignorecase                  " case insensitive by default
    set infercase                   " case inferred by default
    set nowrap                      " do not wrap line
    set shiftround                  " when at 3 spaces, and I hit > ... go to 4, not 5
    set shiftwidth=4                " auto-indent amount when using cindent, >>, << and stuff like that
    set smartcase                   " if there are caps, go case-sensitive
    set softtabstop=4               " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set tabstop=4                   " real tabs should be 8, and they will show with set list on
"}

"Tabs {
    set showtabline=2               " shows the tab bar at all times
    set tabpagemax=10               " maximum amount of tabs to open on startup
"}

"Folding {
    set foldenable                  " Turn on folding
    set foldlevel=100               " Don't autofold anything (but I can still fold manually)
    set foldmarker={,}              " Fold C style code (only use this as default if you use a high foldlevel)
    set foldmethod=marker           " Fold on the marker
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
    function! SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText()   " Custom fold text function (cleaner than default)
    au BufWinEnter * silent loadview
    au BufWinLeave * mkview
"}

"Plugin Settings {
    "Rainbow Parenthesis {
    let g:rainbow_active = 1
    "}

    "vim-plug {
    "from https://github.com/junegunn/vim-plug
    call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'
    Plug 'frazrepo/vim-rainbow'
    Plug 'godlygeek/tabular'
    Plug 'itchyny/lightline.vim'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'plasticboy/vim-markdown'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/syntastic'
    Plug 'tpope/vim-fugitive'
    Plug 'troydm/easybuffer.vim'
    call plug#end()
    "}

    "syntastic {
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    "}

    "NERDTree {
    autocmd vimenter * NERDTreeToggle
    autocmd vimenter * if !argc() | NERDTree | endif
    autocmd VimEnter * wincmd p
    autocmd BufEnter * NERDTreeMirror
    let NERDTreeShowHidden = 1
    let g:NERDTreeWinSize = 35
    " auto quit nerdtree when buffers closed
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
        \ && b:NERDTree.isTabTree()) | q | endif
    " Store the bookmarks file
    let NERDTreeBookmarksFile=expand("$HOME/.vim-NERDTreeBookmarks")
    " Show the bookmarks table on startup
    " let NERDTreeShowBookmarks=1
    " nerdtree statusline
    let NERDTreeStatusline = "%{ getcwd() }"
    "}

    "lightline {
    let g:lightline = { 'colorscheme': 'wombat', }
    "}

    "vim-markdown {
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_no_default_key_mappings=1
    let g:vim_markdown_math=1
    let g:vim_markdown_frontmatter=1
    "}

"}

"Formatting {
    " remove color columns in sh files
    autocmd BufRead,BufNewFile *.sh set colorcolumn=80

    " Python Stuff
    let python_highlight_all=1
    highlight BadWhitespace ctermbg=red guibg=red
    " Display tabs at the beginning of a line in Python mode as bad.
    au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
    " Make trailing whitespace be flagged as bad.
    au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
    " remove colorcolumn
    autocmd BufRead,BufNewFile *.py set colorcolumn=9999
    " End Python stuffs

    " uglify chars past the 80 col limit
    au BufWinEnter *.sh let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

    " Remove the Windows ^M - when the encodings gets messed up
    noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

    let b:match_ignorecase = 1 " case is stupid

    " adding shlibs to sh syntax hilighting
    au BufNewFile,BufRead *.shlib set filetype=sh
"}

"Key mappings / bindings {
    let mapleader=","                       " mapping comma to leader key

    " autoreload vimrc
    augroup reload_vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    augroup END

    " no more up left right down keys. hjkl motherfucker.
    map <up> <nop>
    map <down> <nop>
    map <left> <nop>
    map <right> <nop>

    " Go to tab by number
    noremap <leader>1 1gt
    noremap <leader>2 2gt
    noremap <leader>3 3gt
    noremap <leader>4 4gt
    noremap <leader>5 5gt
    noremap <leader>6 6gt
    noremap <leader>7 7gt
    noremap <leader>8 8gt
    noremap <leader>9 9gt
    noremap <leader>0 :tablast<cr>

    " Easybuffer
    nmap <silent> <F7> :EasyBuffer<CR>

    " nerdtree
    map <C-n> :NERDTreeToggle<CR>
    map <C-m> :NERDTree<CR>
    nmap <silent> <F3> :NERDTreeToggle<CR>

    "From :
    "https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
    "Remove all trailing whitespace by pressing F9
    nnoremap <F9> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
    "selective remove of trailing whitespace by pressing F10
    nnoremap <F10> :let _s=@/<Bar>:%s/;\s\+$/;/e<Bar>:let @/=_s<Bar><CR>

    " Buffer navigation
    map <C-H> :bp!<ENTER>
    map <C-L> :bn!<ENTER>

"}

"StatusLine {
    "" http://stackoverflow.com/questions/5375240/a-more-useful-statusline-in-vim
    hi User1 guifg=#ffdad8 guibg=#880c0e ctermfg=15 ctermbg=88
    hi User2 guifg=#000000 guibg=#F4905C ctermfg=0  ctermbg=208
    hi User3 guifg=#292b00 guibg=#f4f597 ctermfg=0  ctermbg=227
    hi User4 guifg=#112605 guibg=#aefe7B ctermfg=0  ctermbg=120
    hi User5 guifg=#051d00 guibg=#7dcc7d ctermfg=0  ctermbg=66
    hi User7 guifg=#ffffff guibg=#880c0e ctermfg=15 ctermbg=88   gui=bold
    hi User8 guifg=#ffffff guibg=#5b7fbb ctermfg=15 ctermbg=69
    hi User9 guifg=#ffffff guibg=#810085 ctermfg=15 ctermbg=90
    hi User0 guifg=#ffffff guibg=#094afe ctermfg=15 ctermbg=0

    set statusline=
    set statusline+=%7*\[%n]                                  "buffernr
    set statusline+=%1*\ %<%F\                                "File+path
    set statusline+=%2*\ %y\                                  "FileType
    set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
    set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
    set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
    set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
    set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
    set statusline+=%9*\ col:%03c\                            "Colnr
    set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

    function! HighlightSearch()
        if &hls
            return 'H'
        else
            return ''
        endif
    endfunction
"}

"Folder creations for mappings {
    silent !mkdir ~/.vim/backup > /dev/null 2>&1
    silent !mkdir ~/.vim/tmp > /dev/null 2>&1
    silent !mkdir ~/.vim/undo > /dev/null 2>&1
    silent !mkdir ~/.vim/swap > /dev/null 2>&1
"}
