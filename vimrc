"#############################################################################
"############################# Alex Hahn Vimrc ###############################
"#############################################################################

" Table Of Contents
"=========================================================================
" Section:
"   - Todo's
"   - View / Layout settings
"   - Insert Mode settings
"   - Command Mode settings
"   - Key Mappings
"   - Haskell Features
"=========================================================================

execute pathogen#infect()

"-------------------------------------------------------------------------
" Todo's
"-------------------------------------------------------------------------

" - Better refactoring (like intelliJ, change all instances of current word
" - Fix the tags/ goto declaration/ instance/ useages set up
" - Command to comment current line (haskell insert -- at begining of line
" - GHC Mod package to help with type inspection/ autocomplete?
"-------------------------------------------------------------------------




"-------------------------------------------------------------------------
" View / Layout settings
"-------------------------------------------------------------------------
syntax on  " Turn on syntax highlightling
filetype on
filetype plugin on
filetype plugin indent on
set number                  " Turn on line numbers
set background=dark         " Use dark background, determined light or dark mode of some color schemes
set laststatus=2
"set statusline

" Custom colorschemes (need to have <name>.vim file in .vim/colors/) , uncomment one
colorscheme gruvbox

" Easier split screen navigation, instead of ctrl w j it's just ctrl j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Easier swap panel shortcuts




"-------------------------------------------------------------------------
" Insert Mode settings
"-------------------------------------------------------------------------
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent

" highlight lines longer than 80 chars
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"-------------------------------------------------------------------------


"-------------------------------------------------------------------------
" Command Mode settings
"-------------------------------------------------------------------------
set ignorecase
set smartcase
set hlsearch
set incsearch
set nowrapscan
set showmatch

let mapleader = "["


" Turn on tags (follow implementation/ definitions with ctrl {
set tags=./tags,tags;$HOME/bllp-platform

" Save on certain commands automatically. Especially useful for using tags,
" basically when a file has changed and not been saved searching a tag will
" fail. With this when you hit ctrl ] the file saves automatically so the
" search/ tag will update
set autowrite

" :WE <filename> writes current file, closes it (no buffer created) and opens
" the new file in the current panel. Using just :e constantly creates new
" buffers which isn't great
" ToDo: this doesn't have autocomplete path/ filename which is terrible, fix
command -nargs=+ WE w | bd | e <args>

" turn of current highlighted search with ctrl h
" ToDo: I don't think this actually works... look into
nnoremap <c-c> (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

"use sytem clipboard when yanking by default
set clipboard=unnamedplus

"Find and replace word under cursor (automatically does :%s/<word under
"cursor> / <whatever you type> /g)
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>



" TODO need to add hlint to the syntax checker https://github.com/vim-syntastic/syntastic also just fix in general
" Syntax/ active type checking
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
"-------------------------------------------------------------------------


"-------------------------------------------------------------------------
" Key Mappings
"-------------------------------------------------------------------------

" Map all combinations of jk to Escape from insert mode
imap jk <ESC>
imap JK <ESC>
imap Jk <ESC>
imap jK <ESC>

" Map semicolon to colon so when you don't hit shift fast enough it still goes to command mode
nmap ; :

" Similarly map the save and quit commands to their caps version as well (doesn't change any behavior as they're unmapped to start)
command W w
command Q q
command Wq wp
command WQ wq

" Move between open buffers with ctrl n and p
 nmap <C-n> :bnext<CR>
 nmap <C-p> :bprev<CR>
"-------------------------------------------------------------------------

"-------------------------------------------------------------------------
" Haskell Features
"-------------------------------------------------------------------------

"tagbar
nmap <F8> :TagbarToggle<CR>


