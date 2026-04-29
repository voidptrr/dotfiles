set ignorecase
set smartcase
set mouse=a
set scrolloff=10
set backspace=indent,eol,start
set splitbelow
set splitright
set updatetime=250

if has('clipboard')
  set clipboard=unnamedplus
endif

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

set path+=**
set wildmenu

set laststatus=2
set statusline=
set statusline +=%1*\ %n\ %* 
set statusline +=%5*%{&ff}%* 
set statusline +=%3*%y%* 
set statusline +=%4*\ %<%F%* 
set statusline +=%2*%m%* 
set statusline +=%1*%=%5l%* 
set statusline +=%2*/%L%* 
set statusline +=%1*%4v\ %* 
set statusline +=%2*0x%04B\ %*
