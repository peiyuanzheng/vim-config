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
  call s:LeaderF()
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


function! s:LeaderF() "{{{
  let g:Lf_ShortcutF = '<c-p>'
  noremap <c-m> :LeaderfMru<cr>
  noremap <m-b> :LeaderfBuffer<cr>
  noremap <m-f> :LeaderfFunction<cr>
  noremap <m-t> :LeaderfTag<cr>

  " 通过Leaderf rg在当前buffer中搜索光标下的字符串，需按回车确认。
  noremap `b :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
  " 通过Leaderf rg搜索光标下的字符串，需按回车确认。
  noremap `f :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
  " 通过Leaderf rg搜索高亮文本
  xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
  " 打开最近一次Leaderf rg搜索窗口
  noremap go :<C-U>Leaderf! rg --recall<CR>

  let g:Lf_HideHelp = 1
  let g:Lf_UseCache = 0
  let g:Lf_UseVersionControlTool = 0
  let g:Lf_PreviewInPopup = 1
  let g:Lf_WorkingDirectoryMode = 'Ac'
  let g:Lf_WindowHeight = 0.3
  let g:Lf_ShowRelativePath = 0
  let g:Lf_CacheDirectory = expand('~/.vim/cache')
  let g:Lf_StlColorscheme = 'gruvbox_material'
  let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
  let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
  let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
endfunction "}}}


" vim:set ft=vim et sw=2:
