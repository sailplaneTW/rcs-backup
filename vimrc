set encoding=utf-8
set fileencodings=utf-8,big5,cp950
set termencoding=utf-8,big5


syntax on      
set nocompatible 
" set ai           
set shiftwidth=4
set tabstop=4    
set softtabstop=4
set expandtab   

set ruler        
set backspace=2  
set ic           
set ru           
set hlsearch     
set incsearch    
set smartindent  
set confirm      
set history=100  
set cursorline   

set laststatus=2
set statusline=%4*%<\%m%<[%f\%r%h%w]\ [%{&ff},%{&fileencoding},%Y]%=\[Position=%l,%v,%p%%]

set nobk

colorscheme torte

" NERD TREE " {{{
" notes:
"
" o       Open selected file, or expand selected dir               
" go      Open selected file, but leave cursor in the NERDTree     
" t       Open selected node in a new tab                          
" T       Same as 't' but keep the focus on the current tab        
" <tab>   Open selected file in a split window                     
" g<tab>  Same as <tab>, but leave the cursor on the NERDTree      
" !       Execute the current file                                 
" O       Recursively open the selected directory                  
" x       Close the current nodes parent                           
" X       Recursively close all children of the current node       
" e       Open a netrw for the current dir                         

" default <leader> is '\'
map <leader>e :NERDTreeToggle<CR>
"}}}

set noignorecase
set background=dark

set tags=./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,../../../../../../tags

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

an 50.20 &View.File\ Viewer<Tab><F5> <ESC>:NERDTreeToggle<CR>
map <F5> <ESC>:NERDTreeToggle<CR> " Toggles NERD Tree view (file viewer)

" Open and close all the three plugins on the same time
nmap <F8> <ESC>:TrinityToggleAll<CR>
" Open and close the srcexpl.vim separately
nmap <F8> <ESC>:TrinityToggleSourceExplorer<CR>
" Open and close the taglist.vim separately
nmap <F8> <ESC>:TrinityToggleTagList<CR>
" Open and close the NERD_tree.vim separately
nmap <F8> <ESC>:TrinityToggleNERDTree<CR>
map <F2> <Esc>:1,$!xmllint --format -<CR>

set mouse=nv

