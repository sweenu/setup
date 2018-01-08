" Basic options
set clipboard=unnamed,unnamedplus
set colorcolumn=80
set laststatus=2
set expandtab
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set ignorecase
set smartcase

" Plugin setup with Plug
call plug#begin('~/.local/share/nvim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'dag/vim-fish'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'kien/ctrlp.vim'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pearofducks/ansible-vim'
Plug 'saltstack/salt-vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
" Plug 'python-mode/python-mode'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/indentpython.vim'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'zchee/deoplete-jedi'
call plug#end()

" Per plugin configuration
source ~/.config/nvim/airline.vim
source ~/.config/nvim/ale.vim
source ~/.config/nvim/deoplete.vim
source ~/.config/nvim/deoplete-jedi.vim

" Colors configuration
set termguicolors
colorscheme base16-oceanicnext

" Special mapping
map <C-\> :NERDTreeToggle<CR>
map <M-t> :TagbarOpenAutoClose<CR>
map <M-g>b :Gblame<CR>
map <M-g>d :Gdiff<CR>
map <M-#> :StripWhitespace<CR>
map <M-b> oimport pdb; pdb.set_trace()<Esc>
map Y y$

" Split mapping
map <M-x> :q<CR>
nnoremap <M-j> <C-W><C-J>
nnoremap <M-k> <C-W><C-K>
nnoremap <M-l> <C-W><C-L>
nnoremap <M-h> <C-W><C-H>

" Map movement through errors without wrapping.
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)
