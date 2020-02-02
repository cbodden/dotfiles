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
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
    au Syntax * RainbowParenthesesLoadChevrons
    au Syntax * RainbowParenthesesLoadRound
    "}

    "pathogen {
    call pathogen#helptags()
    call pathogen#infect()
    execute pathogen#infect()
    "}

    "vundle {
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'gmarik/vundle'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'fatih/vim-go'
    Plugin 'itchyny/lightline.vim'
    Plugin 'jlanzarotta/bufexplorer'
    Plugin 'majutsushi/tagbar'
    Plugin 'ryanss/vim-hackernews'
    Plugin 'scrooloose/syntastic'
    Plugin 'tpope/vim-fugitive'
    Plugin 'troydm/easybuffer.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'dracula/vim'
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
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    " Store the bookmarks file
    let NERDTreeBookmarksFile=expand("$HOME/.vim-NERDTreeBookmarks")
    " Show the bookmarks table on startup
    " let NERDTreeShowBookmarks=1
    " nerdtree statusline
    let NERDTreeStatusline = "%{ getcwd() }"
    "}

    "bash completer {
    "http://www.vim.org/scripts/script.php?script_id=365
    "http://www.thegeekstuff.com/2009/02/make-vim-as-your-bash-ide-using-bash-support-plugin/
    filetype plugin on
    let g:BASH_AuthorName   = 'CBodden'
    let g:BASH_Email        = 'cesar@pissedoffadmins.com'
    let g:BASH_Company      = 'pissedoffadmins.com'
    "}

    "lightline {
    let g:lightline = { 'colorscheme': 'wombat', }
    "}

    "YouCompleteMe {
    let g:ycm_confirm_extra_conf = 0    " remove initial load message
    "}

    "https://github.com/jstemmer/gotags {
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ } "}

    "TagList Settings {
        let Tlist_Auto_Open=0               " let the tag list open automagically
        let Tlist_Compact_Format = 1        " show small menu
        let Tlist_Ctags_Cmd = 'ctags'       " location of ctags
        let Tlist_Enable_Fold_Column = 0    " do show folding tree
        let Tlist_Exist_OnlyWindow = 1      " if you are the last, kill yourself
        let Tlist_File_Fold_Auto_Close = 0  " fold closed other trees
        let Tlist_Sort_Type = "name"        " order by
        let Tlist_Use_Right_Window = 1      " split to the right side of the screen
        let Tlist_WinWidth = 35             " 40 cols wide, so i can (almost always) read my functions
        " Language Specifics {
            " just functions and classes please
            let tlist_aspjscript_settings = 'asp;f:function;c:class'
            " just functions and subs please
            let tlist_aspvbs_settings = 'asp;f:function;s:sub'
            " don't show variables in freaking php
            let tlist_php_settings = 'php;c:class;d:constant;f:function'
            " just functions and classes please
            let tlist_vb_settings = 'asp;f:function;c:class'
        " }
    " }

    "vim-markdown {
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_no_default_key_mappings=1
    let g:vim_markdown_math=1
    let g:vim_markdown_frontmatter=1
    "}

    "ctrlp {
    let g:ctrlp_map = '<c-P>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_working_path_mode = 'ra'
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
    let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
    " }

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
    let perl_extended_vars=1 " highlight advanced perl vars inside strings

    " adding shlibs to sh syntax hilighting
    au BufNewFile,BufRead *.shlib set filetype=sh
"}

"Key mappings / bindings {
    let mapleader=","                       " mapping comma to leader key

    cmap w!! w !sudo tee >/dev/null %       " incase you forget to sudo a file when saving - just type "w!!"

    " Quickly edit/reload the vimrc file
    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>

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

    " Tagbar
    "autocmd VimEnter * TagbarOpen
    "autocmd BufEnter * TagbarOpen
    nmap <silent> <F8> :TagbarToggle<CR>

    " Easybuffer
    nmap <silent> <F7> :EasyBuffer<CR>

    " nerdtree
    map <C-n> :NERDTreeToggle<CR>
    map <C-m> :NERDTree<CR>
    nmap <silent> <F3> :NERDTreeToggle<CR>

    " testing tig mappings
    " show history in tig
    nnoremap <Leader>gv :!tig %<CR>

    " run present edit in bash
    "map r :!bash %

    " ctrlP remap
    noremap <leader>p :CtrlP<CR>

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
