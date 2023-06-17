"zpybasic.vim - basic settings
"Maintainer: Peiyuan Zheng, peiyuanzheng@gmail.com
"Version: 1.1

"Install in $VIMRUNTIME/autoload
"add `call zpybasic#config()` in .vimrc

" Use :help 'option' to see the documentation for the given option.

if exists('g:loaded_zpybasic') || &cp
  finish
endif
let g:loaded_zpybasic = 1


function! zpybasic#config() abort "{{{
  call s:common()
  call s:mappings()
  call s:tmux_integration()
endfunction "}}}


function s:common() "{{{
  if has('autocmd')
    filetype plugin indent on
  endif
  if has('syntax') && !exists('g:syntax_on')
    syntax enable
  endif

  set autoindent
  set smartindent
  " fix no indent when input '#' as first character
  autocmd FileType python inoremap # X<c-h>#
  " allow backspacing over everything in insert mode
  set backspace=indent,eol,start
  set whichwrap=b,s,<,>,[,]

  set tabstop=4
  set shiftwidth=4
  set expandtab
  set smarttab

  set ignorecase
  set smartcase
  set incsearch
  set hlsearch

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes
  " Give more space for displaying messages.
  set cmdheight=2
  " always show the status bar
  set laststatus=2
  " show the cursor position all the time
  set ruler
  " display incomplete commands
  set showcmd
  " display completion matches in a status line
  set wildmenu
  set linebreak
  set number
  set relativenumber
  autocmd FileType c,cpp,python setlocal textwidth=100
  autocmd FileType java setlocal textwidth=120

  if !has('nvim') && &ttimeoutlen == -1
    " time out for key codes
    set ttimeout
    " wait up to 100ms after Esc for special key
    set ttimeoutlen=100
  endif

  if !&scrolloff
    set scrolloff=1
  endif
  if !&sidescrolloff
    set sidescrolloff=5
  endif
  set display+=lastline

  " Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it confusing.
  set nrformats-=octal

  if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  endif

  " highlight column after 'textwidth'
  set colorcolumn=+1
  "----- highlight cursor position
  "set cursorline
  autocmd FileType python setlocal cursorcolumn

  " Delete comment character when joining commented lines
  set formatoptions+=j

  if &history < 1000
    set history=1000
  endif
  if &tabpagemax < 50
    set tabpagemax=50
  endif

  if empty(mapcheck('<C-U>', 'i'))
    " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
    " so that you can undo CTRL-U after inserting a line break.
    " Revert with ":iunmap <C-U>".
    inoremap <C-U> <C-G>u<C-U>
  endif
  if empty(mapcheck('<C-W>', 'i'))
    inoremap <C-W> <C-G>u<C-W>
  endif

  set sessionoptions-=options
  set viewoptions-=options

  set t_Co=256
  set background=dark
  colorscheme gruvbox

  set fileencodings=utf-8,euc-cn,cp936,latin1,gb18030     " euc-cn is gbk
  set encoding=utf-8
  set termencoding=utf-8
  set fileencoding=utf-8

  " Load matchit.vim, but only if the user hasn't installed a newer version.
  if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
  else
    set matchpairs+=<:>
    autocmd FileType c,cpp,java set mps+==:;
  endif
  " auto match, eg. ()
  set showmatch

  set wildignore+=*.o,*.obj,*.bak,*~,*.exe,*.pyc
  set noswapfile
  set noundofile
  set hidden
  set autoread

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  set foldmethod=indent
  set foldlevelstart=10

  set mouse=
  " don't make noise
  set vb t_vb=
endfunction "}}}


function s:mappings() "{{{
  "----- shortcuts about split
  nnoremap wv <C-w>v
  nnoremap wc <C-w>c
  nnoremap ws <C-w>s

  "----- shortcuts about move among windows
  noremap <C-H> <C-W>h
  noremap <C-J> <C-W>j
  noremap <C-K> <C-W>k
  noremap <C-L> <C-W>l

  "----- netrw
  let g:netrw_winsize=30
  nnoremap <silent><leader>fe :Sexplore!<CR>

  "----- about vimrc
  nnoremap <silent><leader>sr :source ~/.vimrc<cr>
  nnoremap <silent><leader>er :e ~/.vimrc<cr>
  autocmd! bufwritepost .vimrc source ~/.vimrc

  "----- autoclose '{' and indent
  inoremap {{ {<CR>}<Esc>ko

  "----- turn hlsearch off/on with CTRL-N
  nnoremap <silent> <C-N> :se invhlsearch<cr>

  "----- write file and redraw window
  nnoremap <silent><leader>w :w!<cr>:redraw!<cr>
endfunction "}}}


" see :help tmux-integration
function s:tmux_integration() "{{{
  if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    " Enable modified arrow keys, see  :help arrow_modifiers
    execute "silent! set <xUp>=\<Esc>[@;*A"
    execute "silent! set <xDown>=\<Esc>[@;*B"
    execute "silent! set <xRight>=\<Esc>[@;*C"
    execute "silent! set <xLeft>=\<Esc>[@;*D"
  endif
endfunction "}}}

" vim:set ft=vim et sw=2:
