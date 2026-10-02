" Enable syntax highlighting for supported filetypes
syntax on

" Detect filetypes and load filetype-specific plugins/indent rules
filetype plugin indent on

" Show absolute line numbers
set number

" Show cursor position in the bottom-right ruler
set ruler

" Highlight the current cursor line
set cursorline

" Display a tab character as 4 columns wide
set tabstop=4

" Use 4 spaces for each indentation level
set shiftwidth=4

" Make Tab/Backspace feel like 4 spaces while editing
set softtabstop=4

" Insert spaces instead of real tab characters
set expandtab

" Use smarter automatic indentation for code-like files
set smartindent

" Keep the previous line's indentation when starting a new line
set autoindent

" Highlight all search matches
set hlsearch

" Show search matches while typing the search query
set incsearch

" Make searches case-insensitive by default
set ignorecase

" If the search query contains uppercase letters, make it case-sensitive
set smartcase

" Allow Backspace to delete indentation, line breaks, and inserted text naturally
set backspace=indent,eol,start

" Show a completion menu for command-line mode
set wildmenu

" Always show the status line
set laststatus=2

" Show partially typed normal-mode commands in the bottom-right
set showcmd
