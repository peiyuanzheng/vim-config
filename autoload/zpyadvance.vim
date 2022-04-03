"zpyadvance.vim - advance settings
"Maintainer: Peiyuan Zheng, peiyuanzheng@gmail.com
"Version: 1.1

"Install in $VIMRUNTIME/autoload
"add `call zpyadvance#config()` in .vimrc

if exists('g:loaded_zpyadvance') || &cp
  finish
endif
let g:loaded_zpyadvance = 1


function! zpyadvance#config() abort "{{{
  call s:Ack()
  call s:Nerdtree()
endfunction "}}}


function! s:Ack() "{{{
  if executable('ag')
    let g:ackprg = 'ag -U --vimgrep --ignore build'
  endif
  nnoremap <silent> <F2> :Ack -s <C-R>=expand("<cword>")<CR><CR>
  nnoremap <silent> <F3> :Ack -sw <C-R>=expand("<cword>")<CR><CR>
endfunction "}}}


function! s:Nerdtree() "{{{
  let g:NERDChristmasTree = 1
  let g:NERDTreeDirArrows = 0
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeShowLineNumbers=1
  let g:NERDTreeWinSize = 40
  let g:NERDTreeIgnore = ['\.svn$', '\~$', '\.o$', '\.pyc$']
  nnoremap <silent> <F9> :NERDTreeToggle<CR>
endfunction "}}}


function! s:VimTmuxNavigator() "{{{
  " write the current buffer (only if changed) before navigating from Vim to tmux pane
  let g:tmux_navigator_save_on_switch = 1
  " Disable tmux navigator when zooming the Vim pane
  let g:tmux_navigator_disable_when_zoomed = 1
endfunction "}}}


" vim:set ft=vim et sw=2:
