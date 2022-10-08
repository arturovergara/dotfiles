set tabstop=4
set shiftwidth=4
set noexpandtab
set number
set relativenumber
set numberwidth=1
set background=dark
set encoding=utf-8
set cursorline
set mouse=a
syntax enable
"autocmd VimEnter,VimLeave * silent !tmux set status

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <BS> <Nop>
inoremap <Del> <Nop>

" Prev settings for Lightline plugin
set laststatus=2
set noshowmode
set showtabline=2

" Link other config files
so ~/.config/nvim/files-config.vim
so ~/.config/nvim/plugins.vim
so ~/.config/nvim/plugins-config.vim
so ~/.config/nvim/mappings.vim

" Lua Plugins
lua require('xtrem')

" Set theme
colorscheme neon
" colorscheme PaperColor
" hi BufferInactive guifg=#555454
