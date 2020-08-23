" Plugins
call plug#begin('~/.vim/plugged')
	Plug 'scrooloose/nerdtree'
	Plug 'lifepillar/vim-solarized8'
	Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }
	Plug 'itchyny/lightline.vim'
	Plug 'chrisbra/Colorizer'
	Plug 'ap/vim-css-color'
	Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'junegunn/vim-emoji'
	Plug 'honza/vim-snippets'
	Plug 'SirVer/ultisnips'
	Plug 'fatih/molokai'
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } " A Vim Plugin for Lively Previewing LaTeX PDF Output
call plug#end()

" Set the color scheme to dracula
colorscheme molokai

" Set true colors if the temrinal support it
set termguicolors

" Remap hte escape key to ii
:imap ii <Esc>

" Enable syntax highlighting
syntax enable

" Set line numbers to relative to the current line
set number relativenumber
let g:rehash256 = 1
let g:rainbow_active = 1

" Use system clipboard
set clipboard=unnamed

" Remove the pipe symbol in split view
set fillchars+=vert:\ 

" Enter the current millenium
set nocompatible


" For usage with Latex
" " For latex
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
" pdf viewer
let g:livepreview_previewer = 'xreader'
" Live preview
let g:livepreview_engine = 'lualatex'

" Use spaces instead of tabs
set tabstop=4
set shiftwidth=4
set expandtab

" lightline color scheme
let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ }

" Remap the split view navigation keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remap the NerdTreeToggle
nmap <C-P> :NERDTreeToggle<CR>
