set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'                  " Required by vundle
Plugin 'mileszs/ack.vim'                       " ACK
Plugin 'neovim/nvim-lspconfig'                 " requred by completion-nvim
Plugin 'nvim-lua/completion-nvim'  
Plugin 'lyokha/vim-xkbswitch'                  " Auto switch kb layout in insert/command mode.
Plugin 'godlygeek/tabular'                     " vim-markdown requirement
Plugin 'plasticboy/vim-markdown'               " markdown support
Plugin 'JamshedVesuna/vim-markdown-preview'    " markdown preview
Plugin 'vimwiki/vimwiki'                       " wiki


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
" ------------------------------------------------------------------------------------------------------------------
" lyokha/vim-xkbswitch config
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = '/home/snems/.local/lib/libxkbswitch.so'
let g:XkbSwitchIMappings = ['ru']
" ------------------------------------------------------------------------------------------------------------------
" vimwiki config
let g:vimwiki_list = [{'path': '/home/snems/wiki/work/', 'syntax': 'markdown',
                     \ 'ext': '.md'}]
" ------------------------------------------------------------------------------------------------------------------
if executable('pyls')
	    au User lsp_setup call lsp#register_server({
		        \ 'name': 'pyls',
		        \ 'cmd': {server_info->['pyls']},
		        \ 'whitelist': ['python'],
		        \ })
endif
" ------------------------------------------------------------------------------------------------------------------
set undodir=~/tmp/vim-undo
set undofile                     "Save history of changes

set tabstop=4
set shiftwidth=4

set list
set listchars=tab:>-

" Save cursor position
augroup resCur
	autocmd!
	autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
" GSL support
au! BufRead,BufNewFile *.gsl  setfiletype gsl 

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
""
"" " Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
""
"" " Avoid showing message extra message when using completion
set shortmess+=c
" ---------------------------------
"set relativenumber
"set number

"set colorcolumn=81
"set textwidth=80
"

