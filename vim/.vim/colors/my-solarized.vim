"these lines are suggested to be at the top of every colorscheme
hi clear
if exists("syntax_on")
  syntax reset
endif

"Load the 'base' colorscheme - the one you want to alter
runtime colors/solarized.vim

"Override the name of the base colorscheme with the name of this custom one
let g:colors_name = "my-solarized"

"Clear the colors for any items that you don't like
hi clear StatusLine
hi clear StatusLineNC

"Set up your new & improved colors
"hi StatusLine guifg=black guibg=white
"hi StatusLineNC guifg=LightCyan guibg=blue gui=bold

hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#000000  guibg=#F4905C
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe
