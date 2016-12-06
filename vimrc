"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700
 
" Vundle to manage plugins
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'jlanzarotta/bufexplorer'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'othree/html5.vim'
Plug 'othree/html5-syntax.vim'
Plug 'groenewege/vim-less'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'leafgarland/typescript-vim'

call plug#end()

" javascript libraries syntax
autocmd BufReadPre *.js let b:javascript_lib_use_react = 1

" Enable filetype plugin
filetype plugin on
filetype indent on
" Supertab ctags shortcut
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
  
" Tablist plugin
let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1

" Set to auto read when a file is changed from the outside
set autoread
  
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
    
" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>
     
" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7
 
set wildmenu " Turn on WiLd menu
 
" Always show current position
set ruler 
  
" The commandbar height
set cmdheight=2 
   
" Change buffer - without saving
set hid 
     
" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
       
" Ignore case when searching
set ignorecase
set smartcase
       
" Highlight search things
set hlsearch
        
" Make search act like search in modern browsers
set incsearch

" Don't redraw while executing macros 
set nolazyredraw
          
" Set magic on, for regular expressions
set magic
           
" Show matching bracets when text indicator is over them
set showmatch
" How many tenths of a second to blink
set mat=2
            
" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable 
  
" Set font according to system
set gfn=Monospace\ 10
set shell=/bin/bash

             
if has("gui_running")
   set guioptions-=T
   set t_Co=256
   set background=dark
   colorscheme delek
   set nonu
else
   colorscheme delek
   set background=dark
   set nonu
endif
                               
set encoding=utf8
try
    lang en_US
catch
endtry
                                    
" Default file types
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile
  
" Persistent undo
set undodir=~/.vim_runtime/undodir
set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set softtabstop=2
set number
set smarttab
  
set lbr
set tw=500
   
" Auto indent
set ai
" Smart indet
set si
" Wrap lines
set nowrap

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
  
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
   
      
function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction 
                 
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
                          
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
 
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif
                                                                 
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Remember info about open buffers on close
set viminfo^=%
