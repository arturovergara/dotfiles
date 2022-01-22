call plug#begin('~/.vim/plugged')

" Theme
Plug 'nlknguyen/papercolor-theme'

" Lightline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Useful stuff
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
" Plug 'SirVer/ultisnips'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax Python
Plug 'vim-syntastic/syntastic'
Plug 'vim-python/python-syntax'
Plug 'Yggdroot/indentLine'
Plug 'lepture/vim-jinja'

" Syntax JS & React
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" CSS Colors
Plug 'ap/vim-css-color'

" Docker & Devops
Plug 'ekalinin/Dockerfile.vim'

call plug#end()