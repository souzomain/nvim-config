call plug#begin()
    if has('nvim')
        "neovim native lsp config
        Plug 'neovim/nvim-lspconfig'

        " auto complete
        Plug 'hrsh7th/nvim-cmp'
        Plug 'hrsh7th/cmp-nvim-lsp'

        " autopairs
        Plug 'windwp/nvim-autopairs'

        " better colors for syntax
        Plug 'nvim-treesitter/nvim-treesitter'

        "lspsaga 
        Plug 'glepnir/lspsaga.nvim'

        "snippet
        Plug 'L3MON4D3/LuaSnip'
        Plug 'saadparwaiz1/cmp_luasnip'
    endif
    "nerdtree
    Plug 'scrooloose/nerdtree'
    
    "tagbar
    Plug 'majutsushi/tagbar'
    
    "icons
    Plug 'ryanoasis/vim-devicons'
    
    "Tab
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    "Theme
    Plug 'dracula/vim',{'as':'dracula'}

    "Fuzz
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim' 
call plug#end()
