set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Align'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'stevearc/vim-arduino'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'pandysong/ghost-text.vim'

" For deoplete.
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

" map jk to escape
inoremap jk <ESC>
set modeline


" colour scheme
if has('gui_running')
  set background=dark
  colorscheme solarized
  if has("gui_gtk2")
      set guifont=Monospace\ 10
  elseif has("gui_win32")
      set guifont=Consolas:h11
  end
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

" fill rest of line with characters
function! FillLine( str )
    " set tw to the desired total length
    let tw = &textwidth
    if tw==0 | let tw = 80 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction
map <F2> :call FillLine('-')

" for python and c files
au BufNewFile,BufRead *.py,*.c,*.cpp,*.ino,*.json,*.go
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set nu |
    \ set colorcolumn=+1


" mark erroneous white space in python files
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" for C
map <F4> :w<cr>:make!<cr>
map <F5> :w<cr>:make!<cr>:!./%<<cr>

" other formatting 
set hlsearch
nnoremap <F3> :set hlsearch!<CR>
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" enable syntax highlighting
let python_highlight_all=1
syntax on

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred


" auto-complete customisation
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" do not show .pyc in nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" shell command for output of system command to new window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" for vim-latex -------------------------------------------------------
" ---------------------------------------------------------------------
"
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" for omnicomplete and map ctrl/space to be same as youcompleteme
set omnifunc=syntaxcomplete#Complete 
inoremap <C-@> <c-x><c-o>

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'

function SetXeTex()
  let g:Tex_CompileRule_pdf = 'xelatex -aux-directory=F:/Vim/my_latex_doc/temp --synctex=-1 -src-specials -interaction=nonstopmode $*'
endfunction
map <Leader>lx :<C-U>call SetXeTex()<CR><

" for vim-go
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
