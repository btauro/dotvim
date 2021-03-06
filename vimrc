" install vundle if it doesn't exist
let vundle_initialized=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
    let vundle_initialized=0
endif

" Use :PluginUpdate to update plugins, :PluginInstall! to reinstall

if version >= 720
    set colorcolumn=80
    set undofile
    set undodir=~/.vim/tmp/undo//,~/.tmp//,/tmp//
    " save my undo history for this buff along with the file
    " could save some headaches
    " the // causes fully qualified path to be in the swp name
    " max number of undos; default is 1000 on UNIX
    "set undolevels=500
    " max number of lines to save in the .un file, default is 10000
    "set undorelad=500
endif

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" this one must come first
Plugin 'gmarik/Vundle.vim'                " github repos for plugins
Plugin 'scrooloose/nerdcommenter.git'     " easy comments key commands
Plugin 'majutsushi/tagbar.git'            " view defined functions in a file using ctags
Plugin 'scrooloose/nerdtree.git'          " view file tree
Plugin 'Shougo/neocomplete.git'           " autocompletion
Plugin 'Shougo/vimproc.git'               " shell stuff
Plugin 'Shougo/vimshell.git'              " ^
Plugin 'Bling/vim-airline.git'            " pretty line at bottom
Plugin 'kien/ctrlp.vim.git'               " a fuzzy finder
Plugin 'kien/rainbow_parentheses.vim.git' " visual parens
Plugin 'tpope/vim-dispatch.git'           " for building asynchronously w/tmux etc (:Make, :Dispatch, and :Copen)
Plugin 'tpope/vim-fugitive.git'           " for Git
Plugin 'gregsexton/gitv.git'              " gitk for vim  (i prefer to use the Tig commands below)
Plugin 'flazz/vim-colorschemes'           " self-explanatory
Plugin 'dyng/ctrlsf.vim'                  " asynch ack/ag search results
Plugin 'terryma/vim-multiple-cursors'     " Sublime-style multiple selection
Plugin 'junegunn/vim-easy-align'          " alignment around delimiters
Plugin 'w0rp/ale'                         " linting
Plugin 'mbbill/undotree'                  " visual history of undo log
Plugin 'machakann/vim-sandwich.git'       " operator surround
Plugin 'wellle/targets.vim'               " extended text objects
Plugin 'lervag/vimtex'                    " latex support

call vundle#end()

filetype plugin indent on

if vundle_initialized  == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

" ================
" GENERAL SETTINGS
" ================

""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""
syntax enable

colorscheme molokai

set bg=dark
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = "dark"


" Terminal 256 colors
" set t_Co=256

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac

" show line numbers
set number


" better filename completion in vim command line
set wildmode=list:longest,full
set wildmenu

" underline!
set cursorline
"set cursorcolun

" Search/replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" tell me when i'm in insert or visual mode
set showmode

" show me the command being typed currently
set showcmd

" don't ding at me
set noerrorbells
set novisualbell 

" where to put swp files
set directory=~/.vim/tmp/swp//,~/.tmp//,/tmp//

" don't create foo~ files
set nobackup

" to try to get rid of 'hit ENTER to continue' prompts
set shortmess=a
set cmdheight=1

" always give me at least 3 lines before and after cursor
set scrolloff=3

" tab settings
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set ttyfast  " we have a fast terminal

" remap ; to : in command mode and replace it with , (saves a key press)
nore ; :
nore , ;


" avoid that damn "no write since last change" warning when
" switching buffers
set hidden

set encoding=utf-8
set shell=/bin/bash
set lazyredraw  " don't redraw when we don't have to


" tell Ctags to recurse up directories 
" for the tags file
set tags=tags;/

" aesthetics
set background=dark

" show status line at bottom 0=never, 1=when > 1 window open
" 2=always
set laststatus=2


" with these, if you include capitals in a search it'll do
" the right thing, if you just use lowercase,
" it'll be case insensitive
set ignorecase
set smartcase

" %s/p/r -> %s/p/r/g
set gdefault

" highlight search results as I type
set incsearch
set showmatch
" but allow me to get rid of the highlighting afterwards with ,space
nnoremap <CR> :noh<CR>
set hls!

" line wrapping
"set wrap
"set textwidth=80
set formatoptions=qrtn1
" tell me when i'm running on too long
"highlight OverLength ctermbg=red 
"ctermfg=white
"match OverLength /\%80v.\+/

"set up code folding
set nofoldenable     "don't fold by default
set foldmethod=indent   " fold on indentations
set foldnestmax=10   "only fold up to 10 levels
set foldlevel=1     " only show me first fold level


nnoremap j gj
nnoremap k gk
nnoremap <right> :bn<CR>
nnoremap <left>  :bp<CR>
inoremap <right> <ESC>:bn<CR>
inoremap <left>  <ESC>:bp<CR>

" save buffers when we move away from vim
"au FocusLost * :wa

" allow bs to erase previously entered chars, autoindent, \n's etc
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
"set smartindent


" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" do the restore
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	au BufWinEnter * call ResCur()
augroup END


" === KEY MAPPINGS ===

" change <leader> key. defaults is '\', hard to reach
let mapleader=","


" quick window split with ,s[vh] (vertical, horizontal)
nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>sh <C-w>s<C-w>j

" move around splits faster
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" move around tabs faster
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>t1 :tabn 1<CR>
nnoremap <leader>t2 :tabn 2<CR>
nnoremap <leader>t3 :tabn 3<CR>
nnoremap <leader>t4 :tabn 4<CR>

" key mapping to toggle spell checker (apparently this will do the right thing in
" source files. Use zg to whitelist a word
nnoremap <leader>sp :setlocal spell!<CR>


" let me edit my vimrc quickly with ,ev
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
" autoreload vimrc when it's edited
autocmd! bufwritepost vimrc source ~/.vim/vimrc
" quickly reload vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" quicker than reaching for escape
inoremap jj <ESC>

" quick save
nnoremap <leader>w :w<CR>

" sudo save
cnoremap w!! w !sudo tee % > /dev/null

set title

" Insert a lambda: mostly for scheme and haskell
imap <C-Bslash> λ

" Use better syntax highlighting for ASM
let g:asmsyntax="asmx86"

" Haskell Mode
let g:haddock_browser = "/usr/bin/google-chrome"
au Bufenter *.hs compiler ghc



" =======================
" PLUGIN-SPECIFIC OPTIONS
" =======================

" ++++++++++ TagBar ++++++++++++
"make TagBar a little easier: press ',1' in command mode to bring it up
let g:tagbar_usearrows = 1
nnoremap <leader>1 :TagbarToggle<CR>
" Uncomment this line to open Tagbar on startup for code files
" au BufRead *.[ch],*.cpp,*.java,*.js,*.py,*.pl TagbarOpen
let g:tagbar_type_julia = {
    \ 'ctagstype' : 'julia',
    \ 'kinds'     : ['a:abstract', 'i:immutable', 't:type', 'f:function', 'm:macro']
    \ }
" !++++++++++ TagBar ++++++++++++!


" ++++++++ NERDTree ++++++++++
nnoremap <leader>2 :NERDTreeToggle<CR>
" !++++++++ NERDTree ++++++++++!

" +++++++ Rainbow Parens ++++++++++
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" !+++++++ Rainbow Parens ++++++++++!


" +++++++ Undotree ++++++++++
nnoremap <F5> :UndotreeToggle<cr>
"!+++++++ Undotree ++++++++++!



" +++++++++ NEOCOMPLETE +++++++++

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

"" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"

endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" !+++++++++ NEOCOMPLETE +++++++++!


" +++++++++ CtrlP ++++++++++++++++++
let g:ctrlp_cmd = "CtrlP"

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(iso|bin|o|ko|d|exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" no file limit
let g:ctrlp_max_files = 0

" Easy bindings for its various modes
nnoremap <leader>pb :CtrlPBuffer<cr>
nnoremap <leader>pm :CtrlPMixed<cr>
nnoremap <leader>pu :CtrlPMRU<cr>
nnoremap <leader>pt :CtrlPTag<cr>

"!+++++++++ CtrlP ++++++++++++++++++!


" +++++++++ CtrlSF ++++++++++++++++++
"
nmap <C-F>7 <Plug>CtrlSFPrompt    " bring up search in prompt
nmap <C-F>8 <Plug>CtrlSFCwordExec " search for thing under cursor

" focus to result window immediately
let g:ctrlsf_auto_focus = {
            \ "at" : "done",
            \ "duration_less_than": 1000
            \ }

"!+++++++++ CtrlSF ++++++++++++++++++!

" +++++++++ vim-easy-align ++++++++++++++++++
" Start interactive EasyAlign in visual mode (e.g. vipma)
xmap ma <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. maip)
nmap ma <Plug>(EasyAlign)
"!+++++++++ vim-easy-align ++++++++++++++++++!


" +++++++++ VimShell ++++++++++++++++++
nnoremap <leader>sh :new \| VimShell zsh<CR>
nnoremap <leader>sv :vnew \| VimShell zsh<CR>
nnoremap <leader>st :VimShellTab zsh<CR>
"!+++++++++ VimShell ++++++++++++++++++!




