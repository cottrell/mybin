" .vimrc

source /Users/davidcottrell/.vimrc_python

colorscheme desert
" set foldmethod=indent
syntax on
" set tabstop=4	" seems to do bad things
set autoindent
au BufRead,BufNewFile *.vue,*.c,*.h,*.C,*.H,*.html,*.js,*.txt.nogit,*.md set softtabstop=4
au BufRead,BufNewFile *.vue,*.c,*.h,*.C,*.H.*.html,*.js,*.txt.nogit,*.md set tabstop=4
au BufRead,BufNewFile *.vue,*.c,*.h,*.C,*.H,*.cpp,*.CPP,*.hpp,*.HPP,*.html,*.js set foldmethod=syntax
au BufRead,BufNewFile *.vue,*.sh,*.ksh,*.bash,*.m,*.pl,*.html,*.js set textwidth=200
au BufRead,BufNewFile *.vue,*.tex,*.sh,*.ksh,*.bash,*.m,*.pl,*.html,*.js,*.txt.nogit,*.md set softtabstop=4
au BufRead,BufNewFile *.vue,*.tex,*.sh,*.ksh,*.bash,*.m,*.pl,*.html,*.js,*.txt.nogit,*.md set expandtab
au BufRead,BufNewFile *.vue,*.tex,*.sh,*.ksh,*.bash,*.m,*.pl,*.html,*.js,*.txt.nogit,*.md set shiftwidth=4
set hlsearch
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
" au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/

filetype plugin indent on

autocmd FileType make setlocal noexpandtab

"to insert spaces at the beginning of a line and real tab characters elsewhere:
inoremap <Silent> <Tab> <C-R>=(col('.') > (matchend(getline('.'), '^\s*') + 1))?'<C-V><C-V><Tab>':'<Tab>'<CR>

" shift tab for real tabs
inoremap <S-Tab> <C-V><Tab> 

set statusline=%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2

" execute pathogen#infect()
" let g:pymode_rope = 0
" let g:pymode_folding = 0
