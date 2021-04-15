language is_IS

" Teach vim to fish
if &shell =~# 'fish$'
    set shell=sh
endif

" Minimal Configuration
set nocompatible
filetype plugin indent on

call plug#begin('~/.config/nvim/plugged')
" Make sure you use single quotes

" fish support for vim
if !exists('g:vscode')
	Plug 'dag/vim-fish'
endif

" Airline is a plugin that makes the status line look fancier.
" It requires a custom font (with arrows), and is completely optional
if !exists('g:vscode')
	Plug 'vim-airline/vim-airline'
endif

if !exists('g:vscode')
	Plug 'vim-airline/vim-airline-themes'
endif

" A more convenient (than default) directory browser for Vim
if !exists('g:vscode')
	Plug 'scrooloose/nerdtree'
endif
if !exists('g:vscode')
	Plug 'Xuyuanp/nerdtree-git-plugin'
endif

" This is a core plugin to support autocompletion for most of the things.
" This is also the messiest one, as it requires manual (and periodic) 
" invocation of the build script.
if !exists('g:vscode')
	Plug 'Valloric/YouCompleteMe'
endif

if !exists('g:vscode')
	Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
endif

" Autocompletion for Python
if !exists('g:vscode')
	Plug 'davidhalter/jedi-vim'
endif

" Highlights new/mofified/deleted lines in the "gutter"
if !exists('g:vscode')
	Plug 'airblade/vim-gitgutter'
endif

" Later in the config I'll bind this plugin to "gc"
" Typing "gc" will comment out a block or line of code in any language
if !exists('g:vscode')
	Plug 'tpope/vim-commentary'
endif

" A Git plugin with a crazy useful command :GitBlame
" Don't wait, blame someone else!
if !exists('g:vscode')
	Plug 'tpope/vim-fugitive'
endif

" vim-one atom colorscheme plugin
if !exists('g:vscode')
    Plug 'https://github.com/rakr/vim-one.git'
endif

" If you prefer Ctrl+h/j/k/l for navigating across vim/tmux splits,
" this plugin will integrate Vim and Tmux, so that you can seamlessly
" Jump across the border of a vim/tmux split
if !exists('g:vscode')
	Plug 'christoomey/vim-tmux-navigator'
endif

" This is the interesting one: it generates a Tmux config that makes
" a tmux status line look like a vim airline with an applied theme
if !exists('g:vscode')
	Plug 'edkolev/tmuxline.vim'
endif

" A wrapper around silversearcher-ag
if !exists('g:vscode')
	Plug 'rking/ag.vim'
endif

" A Vim plugin for all things Go. Supports autocompletion,
" smart code navigation, linting, and much more
if !exists('g:vscode')
	Plug 'fatih/vim-go'
endif

" Never got used to this one, but it allows for wrapping a piece of
" text into "", '', or custom tags
if !exists('g:vscode')
	Plug 'tpope/vim-surround'
endif

" Fzf for ffffuzzzy search~
if !exists('g:vscode')
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
if !exists('g:vscode')
	Plug 'junegunn/fzf.vim'
endif

" Neomake for asynchronous linting and building
if !exists('g:vscode')
	Plug 'neomake/neomake'
endif

" A beautiful autopep8. Have it bound to "ap"
if !exists('g:vscode')
	Plug 'tell-k/vim-autopep8'
endif

" Import sorter for Python
if !exists('g:vscode')
	Plug 'fisadev/vim-isort'
endif

if !exists('g:vscode')
	Plug 'hashivim/vim-terraform'
endif
if !exists('g:vscode')
	Plug 'vim-syntastic/syntastic'
endif
if !exists('g:vscode')
	Plug 'juliosueiras/vim-terraform-completion'
endif
if !exists('g:vscode')
	Plug 'editorconfig/editorconfig-vim'
endif
if !exists('g:vscode')
	Plug 'martinda/Jenkinsfile-vim-syntax'
endif
if !exists('g:vscode')
        Plug 'google/vim-jsonnet'
endif

if !exists('g:vscode')
    Plug 'pedrohdz/vim-yaml-folds'
endif

call plug#end()

" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

set updatetime=500

" Neomake configs to make it a bit less annoying

" When writing a buffer.
call neomake#configure#automake('w')
" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing.
call neomake#configure#automake('rw', 1000)
let g:neomake_open_list = 2

" Airline setup

set laststatus=2
let g:airline_powerline_fonts = 1
" let g:airline_theme = "jellybeans"
let g:airline_theme = 'one'

" Jedi-vim configuration
let g:jedi#show_call_signatures = 1 
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
autocmd FileType python setlocal completeopt-=preview


" Turn on line numbers
set nu
" Turn on syntax highlighting
syntax on
" It hides buffers instead of closing them.
" https://medium.com/usevim/vim-101-set-hidden-f78800142855
set hidden
" Highlights search results as you type vs after you press Enter
set incsearch
" Ignore case when searching
set ignorecase
set smartcase 
" Turns search highlighting on
set hlsearch
" Expands TABs into whitespaces
set tabstop=2
set expandtab
set shiftwidth=2  
" Exclude these files from *
set wildignore=*.swp,*.bak,*.pyc,*.class
" Turn on TrueColor
set termguicolors

set foldlevel=5

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore .git --ignore build-out --ignore build-opt --ignore build-dbg -g ""'

endif

" This colorscheme mimics a default Atom colorscheme which I quite like
colorscheme one
set background=dark

" fzf settings
set rtp+=/usr/local/opt/fzf

" Ctrl+P opens a fuzzy filesearch window (powered by Fzf)
nnoremap <C-p> :Files<CR>

nnoremap <C-n> :NERDTreeToggle<CR>

" Switch to last active tab
let g:lasttab = 1
" I really like tt for switching between recent tabs
nmap tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" A bit of autopep8 config
let g:autopep8_disable_show_diff=1
" ap for a quick .py file formatting
nnoremap ap  :Autopep8<CR>
" This is a quick way to call search-and-replace on a current word
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
" cc now hides those annoying search highlihghts after you're done searching
nnoremap cc :let @/ = ""<cr>
" \e to open a NerdTree at in the directory of the currently viewed file
nnoremap <Leader>e :Ex<CR>
" I said write it!
cmap w!! w !sudo tee % >/dev/null

" Don't expland tabs for Go
autocmd BufRead,BufNewFile   *.go setlocal noexpandtab
