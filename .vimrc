" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif


call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'peiyuanzheng/vim-config'

" Initialize plugin system
call plug#end()


call zpybasic#config()
call zpyadvance#config()
call restoreview#auto()
call metacode#mapping(0)
