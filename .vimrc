set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all plugins here
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Use pathogen for package management
" execute pathogen#infect()

" map jk to escape
inoremap jk <ESC>
set modeline

" colour scheme
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" set spell checker
set spelllang=en_gb
set spell

" enable folding
set foldmethod=indent
set foldlevel=99

" make encoding UTF8
set encoding=utf-8

" for python files
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set nu

" enable syntax highlighting
let python_highlight_all=1
syntax on

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred

" mark erroneous white space in python files
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" auto-complete customisation
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

" do not show .pyc in nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
"" Octave syntax
"augroup filetypedetect
"  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
"augroup END
"
"" Use keywords from Octave syntax language file for autocomplete
"if has("autocmd") && exists("+omnifunc")
"   autocmd Filetype octave
"   \ if &omnifunc == "" |
"   \ setlocal omnifunc=syntaxcomplete#Complete |
"   \ endif
"endif
"
"" F5 executes the octave script you are editing
"autocmd FileType octave map <buffer> <f5> ggOpkg load all<esc>Gopause<esc>:w<cr>:!octave -qf %<cr>ddggdd:w<cr>
