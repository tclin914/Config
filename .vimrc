
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'

" Code commentor
Plugin 'scrooloose/nerdcommenter'

" Surround
Plugin 'tpope/vim-surround'

" AutoClose
Plugin 'Townk/vim-autoclose'

" Terminal Vim with 256 colors colorscheme
Plugin 'fisadev/fisa-vim-colorscheme'

" Ariline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Show git branch
Plugin 'tpope/vim-fugitive'

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" SnipMate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Plugin 'dense-analysis/ale'

" let g:ale_fixers = {
" \   'python': ['yapf', 'isort'],
" \ }

" noremap <F2> :ALEFix<CR>

" Plugin 'psf/black'

" Nix
Plugin 'LnL7/vim-nix'

call vundle#end()

" NERDcommentor
let g:NERDSpaceDelims = 1

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#right_sep = '|'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'wombat'
let g:airline#extensions#whitespace#enabled = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

" Switch tabs
nmap <C-w>n :tabn<CR>
nmap <C-w>p :tabp<CR>

" Disable markdown folding
let g:vim_markdown_folding_disabled = 1

" Allow plugins by file type
filetype plugin on

" autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.nix set filetype=nix

noremap <C-d> :sh<cr>

set t_Co=256

" set expandtab
" set tabstop=8
" set softtabstop=8
set shiftwidth=4

set incsearch
set hlsearch

set backspace=2
set autoindent
set ruler
set showmode
set nu
set clipboard=unnamedplus

set scrolloff=15

syntax on

highlight Search ctermfg=black ctermbg=yellow
highlight Visual ctermfg=black ctermbg=yellow
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88

" set cursorline
" if &term =~ "xterm\\|rxvt"
  " " use an orange cursor in insert mode
  " let &t_SI = "\<Esc>]12;orange\x7"
  " " use a red cursor otherwise
  " let &t_EI = "\<Esc>]12;red\x7"
  " silent !echo -ne "\033]12;red\007"
  " " reset cursor when vim exits
  " autocmd VimLeave * silent !echo -ne "\033]112\007"
  " " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
" endif

" High light unwanted spaces in end of line
highlight ExtraWhitespace ctermbg=darkred guibg=darkcyan
autocmd BufEnter * if &ft != 'help' | match ExtraWhitespace /\s\+$/ | endif
autocmd BufEnter * if &ft == 'help' | match none /\s\+$/ | endif

" High light over length in a line
" au BufWinEnter * let w:long_line_match=matchadd('ErrorMsg', '\%>80v.\+', -1)

function! IgnoreDiff(pattern)
    let opt = ""
    if &diffopt =~ "icase"
      let opt = opt . "-i "
    endif
    if &diffopt =~ "iwhite"
      let opt = opt . "-b "
    endif
    let cmd = "!diff -a --binary " . opt .
      \ " <(perl -pe 's/" . a:pattern .  "/\".\" x length($0)/gei' " .
      \ v:fname_in .
      \ ") <(perl -pe 's/" . a:pattern .  "/\".\" x length($0)/gei' " .
      \ v:fname_new .
      \ ") > " . v:fname_out
    echo cmd
    silent execute cmd
    redraw!
    return cmd
endfunction
set diffexpr=IgnoreDiff('^0x[0-9a-f]+') | diffupdate
