call plug#begin('~/.vim/plugged')
" Theme
Plug 'nlknguyen/papercolor-theme'
Plug 'rafamadriz/neon'
Plug 'olivercederborg/poimandres.nvim'

" NerdCommenter
Plug 'preservim/nerdcommenter'

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}


" # Lua Plugins #

" LSP Config
Plug 'neovim/nvim-lspconfig'

" Nvim Treesitter for Syntax Color
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Lualine
Plug 'nvim-lualine/lualine.nvim'

" Navbar
Plug 'romgrk/barbar.nvim'

" Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Linter and formatter
Plug 'dense-analysis/ale'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Indent lines
Plug 'lukas-reineke/indent-blankline.nvim'

" Typing stuff
Plug 'windwp/nvim-autopairs'

" Hex colors
Plug 'norcalli/nvim-colorizer.lua'


call plug#end()
