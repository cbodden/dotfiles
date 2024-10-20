"Modeline and Notes {
"vim: set foldmarker={,} foldlevel=0 spell:
"}

"[Configured Key Bindings] {
    " F2      paste toggle
    " F3      nerdtree toggle
    " F8      tagbar toggle
    " F9      remove all trailing whitespace
    " F10     selective remove of trailing whitespace
    " H       :%s//gc
    " J       :m >+1
    " K       :m <-2
    " :W      :w with sudo
    " ,       leader key
    " ,b :    build go files
    " ,r      go run
    " ,t      go test
    " ,m      remove ^M when encodings get messed up
    " ,gj     :diffget //3  ## fugitive
    " ,gf     :diffget //2  ## fugitive
    " ,gs     :G<CR>        ## fugitive
    " ,1 - 0  go to tab by number
    " <C-n>   nerdtree toggle
    " <C-m>   nerdtree
"}

"[Basics] {
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

"[General] {
    filetype plugin on              " load filetype plugins settings
    " filetype plugin indent on       " load filetype plugins/indent settings
    set autochdir                   " always switch to the current file directory
    set autoread                    " auto read when a file is changed from the outside
    set backspace=indent,eol,start  " make backspace a more flexible
    set backup                      " make backup files
    set backupdir=~/.vim/backup     " where to put backup files
    set clipboard+=unnamed          " share windows clipboard
    set directory=~/.vim/swap       " directory to place swap files in
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
    set swapfile                    " enable swaps
    set tags=~/.vim/tags/           " tag usage
    set timeoutlen=300 ttimeoutlen=0" mapping delays
    set undodir=~/.vim/undo         " persistent undo dir
    set undofile                    " persistent undo regardless of buffer unload
    set undolevels=1000             " many levels of undo
    set updatetime=50               " shorter update time
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

"[Vim UI] {
    colorscheme gruvbox
    set background=dark             " always keep background dark regardless of color theme
    set colorcolumn=80,120          " highlight maximum line length
    " highlight ColorColumn ctermbg=0 guibg=grey
    set cmdheight=2                 " space for displaying messages
    set cursorcolumn                " highlight the current column
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
    set termguicolors               " support for colorscheme in ST
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

"[Text Formatting/Layout] {
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

"[Tabs] {
    set showtabline=2               " shows the tab bar at all times
    set tabpagemax=10               " maximum amount of tabs to open on startup
"}

"[Folding] {
    set foldenable                  " Turn on folding
    set foldlevel=100               " Don't autofold anything (but I can still fold manually)
    set foldmarker={,}              " Fold C style code (only use this as default if you use a high foldlevel)
    set foldmethod=marker           " Fold on the marker
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
    function! SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText()   " Custom fold text function (cleaner than default)
    "au BufWinEnter * silent loadview
    au BufWinLeave * mkview
"}

"[Plugin Settings] {
    "vim-plug {
        call plug#begin('~/.vim/plugged')
        Plug 'airblade/vim-gitgutter'
        " syntax hilighting
        Plug 'dense-analysis/ale'
        "" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
        Plug 'frazrepo/vim-rainbow'
        " status bar
        Plug 'itchyny/lightline.vim'
        " Code Completion
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'preservim/tagbar'
        " code commenter
        Plug 'preservim/nerdcommenter'
        " NERDTree
        Plug 'scrooloose/nerdtree'
        " Git
        Plug 'tpope/vim-fugitive'
        " Finder
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        " Theme
        Plug 'morhetz/gruvbox'
        " Tabs
        Plug 'ap/vim-buftabline'
        call plug#end()
    "}

    "Rainbow Parenthesis {
        let g:rainbow_active = 1
    "}

    "tagbar {
        nmap <F8> :TagbarToggle<CR>
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

        " Close NERDTree when closing the last buffer
        autocmd bufenter * if (winnr("$") == 1
            \ && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    "}

    "lightline {
        let g:lightline = { 'colorscheme': 'gruvbox', }
        " let g:lightline = { 'colorscheme': 'solarized', }
    "}

    "fzf {
        command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always
          \   --smart-case -- '.shellescape(<q-args>), 1,
          \   fzf#vim#with_preview(), <bang>0)
    "}

    "vim-go {
        "Go syntax highlighting
            let g:go_highlight_fields = 1
            let g:go_highlight_functions = 1
            let g:go_highlight_function_calls = 1
            let g:go_highlight_extra_types = 1
            let g:go_highlight_operators = 1

        "Auto formatting and importing
            let g:go_fmt_autosave = 1
            let g:go_fmt_command = "goimports"

        "Status line types/signatures
            let g:go_auto_type_info = 1

        "Run :GoBuild or :GoTestCompile based on the go file
            function! s:build_go_files()
              let l:file = expand('%')
              if l:file =~# '^\f\+_test\.go$'
                call go#test#Test(0, 1)
              elseif l:file =~# '^\f\+\.go$'
                call go#cmd#Build(0)
              endif
            endfunction

        "Map keys for most used commands.
            "Ex: `\b` for building, `\r` for running and `\b` for running test.
            autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
            autocmd FileType go nmap <leader>r  <Plug>(go-run)
            autocmd FileType go nmap <leader>t  <Plug>(go-test)

        "vim-go fix
            silent !go env -w GO111MODULE=off
    "}

    "CoC Settings {
        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Make <CR> to accept selected completion item or notify coc.nvim to format
        " <C-g>u breaks current undo, please make your own choice.
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
        "Ultisnips Settings
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<c-b>"
        let g:UltiSnipsJumpBackwardTrigger="<c-z>"

        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"

        "coc-snippets Settings
        "inoremap <silent><expr> <TAB>
        "      \ coc#pum#visible() ? coc#_select_confirm() :
        "      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        "      \ CheckBackspace() ? "\<TAB>" :
        "      \ coc#refresh()
        "
        "function! CheckBackspace() abort
        "  let col = col('.') - 1
        "  return !col || getline('.')[col - 1]  =~# '\s'
        "endfunction
        "
        "let g:coc_snippet_next = '<tab>'
    "}

    "ale settings {
        " Fix files automatically on save
        let g:ale_fixers = {}
        let g:ale_javascript_eslint_use_global = 1
        let g:ale_linters = {
          \'javascript': ['eslint'],
          \'vue': ['eslint', 'stylelint', 'tsserver'],
        \}

        let g:ale_fixers = {
          \'javascript': ['prettier', 'eslint'],
          \'vue': ['eslint', 'stylelint'],
        \}

        let g:ale_linters_explicit = 1
        let g:ale_sign_column_always = 1
        let g:ale_sign_error = '>>'
        let g:ale_sign_warning = '--'
        let g:ale_fix_on_save = 1
    "}

    " Sweet Sweet FuGITive {
        nmap <leader>gj :diffget //3<CR>
        nmap <leader>gf :diffget //2<CR>
        nmap <leader>gs :G<CR>
    "}

"}

"[Formatting] {
    " [Bash / Shell Scripts] {
        " remove color columns in sh files
        autocmd BufRead,BufNewFile *.sh set colorcolumn=80

        " uglify chars past the 80 col limit
        au BufWinEnter *.sh let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

        " adding shlibs to sh syntax hilighting
        au BufNewFile,BufRead *.shlib set filetype=sh
    "}

    " [Python] {
        let python_highlight_all=1
        highlight BadWhitespace ctermbg=red guibg=red
        " Display tabs at the beginning of a line in Python mode as bad.
        au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
        " Make trailing whitespace be flagged as bad.
        au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
        " remove colorcolumn
        autocmd BufRead,BufNewFile *.py set colorcolumn=9999
    "}

    " [Misc] {
        "Remove the Windows ^M - when the encodings gets messed up
        noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

        let b:match_ignorecase = 1 " case is stupid
    "}
"}

"[Key mappings / bindings] {
    let mapleader=","                       " mapping comma to leader key

    " autoreload vimrc
    augroup reload_vimrc
        autocmd!
        autocmd BufWritePost $MYVIMRC source $MYVIMRC
    augroup END

    " no more up left right down keys. hjkl, motherfuckers.
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

    " nerdtree
    map <C-n> :NERDTreeToggle<CR>
    map <C-m> :NERDTree<CR>
    nmap <silent> <F3> :NERDTreeToggle<CR>

    "Remove all trailing whitespace by pressing F9
    nnoremap <F9> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
    "selective remove of trailing whitespace by pressing F10
    nnoremap <F10> :let _s=@/<Bar>:%s/;\s\+$/;/e<Bar>:let @/=_s<Bar><CR>

    " map <C-P> :Files<CR>
    map <C-f> :Rg<CR>
    map <C-t> :e <cfile><cr>
    map <S-Tab> :bn<CR>
    map <F5> :setlocal spell! spelllang=en_US<CR>

    " Search and replace hotkey
    nnoremap H :%s//gc<left><left><left>

    " Move highlighted text up and down
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv

    " sudo save
    command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
"}

"[Folder creations for mappings] {
    silent !mkdir ~/.vim/backup > /dev/null 2>&1
    silent !mkdir ~/.vim/swap > /dev/null 2>&1
    silent !mkdir ~/.vim/tags > /dev/null 2>&1
    silent !mkdir ~/.vim/tmp > /dev/null 2>&1
    silent !mkdir ~/.vim/undo > /dev/null 2>&1

    if !isdirectory(expand(&undodir))
        call mkdir(expand(&undodir), "p")
    endif
    if !isdirectory(expand(&backupdir))
        call mkdir(expand(&backupdir), "p")
    endif
    if !isdirectory(expand(&directory))
        call mkdir(expand(&directory), "p")
    endif
"}
