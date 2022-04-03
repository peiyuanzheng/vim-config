" Update from: https://www.vim.org/scripts/download_script.php?src_id=22634

"          FILE: restore_view.vim
"      Language: vim script
"    Maintainer: Yichao Zhou (broken.zhou AT gmail dot com)
"       Version: 1.3

"Install in $VIMRUNTIME/autoload
"add `call restore_view#auto()` in .vimrc


if exists("g:loaded_restore_view") || &cp
  finish
endif
let g:loaded_restore_view = 1

if !exists("g:skipview_files")
  let g:skipview_files = []
endif

function! restore_view#auto() abort "{{{
  augroup AutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePre,BufWinLeave ?* if s:MakeViewCheck() | silent! mkview | endif
    autocmd BufWinEnter ?* if s:MakeViewCheck() | silent! loadview | endif
  augroup END
endfunction "}}}

function s:MakeViewCheck() "{{{
  if &l:diff | return 0 | endif
  if &buftype != '' | return 0 | endif
  if expand('%') =~ '\[.*\]' | return 0 | endif
  if empty(glob(expand('%:p'))) | return 0 | endif
  if &modifiable == 0 | return 0 | endif
  if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
  if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif

  let file_name = expand('%:p')
  for ifiles in g:skipview_files
    if file_name =~ ifiles
      return 0
    endif
  endfor

  return 1
endfunction "}}}

" vim:set ft=vim et sw=2:
