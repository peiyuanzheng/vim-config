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
  call s:nerdtree()
  call s:leaderf()
  call s:coc()
endfunction "}}}


function! s:nerdtree() "{{{
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeShowLineNumbers=1
  let g:NERDTreeWinSize = 40
  let g:NERDTreeIgnore = ['\.svn$', '\~$', '\.o$', '\.pyc$']
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  nnoremap <silent> <m-n> :NERDTreeToggle<CR>
endfunction "}}}


function! s:leaderf() "{{{
  " 搜索当前项目目录下的文件 (p:project)
  let g:Lf_ShortcutF = '<m-p>'
  " 搜索最近打开的文件 (u:used)
  noremap <m-u> :LeaderfMru<cr>
  " 搜索buffer (b:buffer)
  noremap <m-b> :LeaderfBuffer<cr>
  " 搜索当前文件中的函数 (m:method)
  noremap <m-m> :LeaderfFunction<cr>
  " 搜索当前文件中的tags (t:tags)
  noremap <m-t> :LeaderfBufTag<cr>

  " 在当前buffer中搜索光标下的字符串，需按回车确认。
  noremap `b :<C-U><C-R>=printf("Leaderf rg --current-buffer -e %s ", expand("<cword>"))<CR>
  " 搜索光标下的字符串，需按回车确认。
  noremap `f :<C-U><C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR>
  " 搜索高亮文本
  xnoremap `v :<C-U><C-R>=printf("Leaderf rg -F -e %s ", leaderf#Rg#visual())<CR>
  " 打开最近一次Leaderf rg搜索窗口
  noremap `o :<C-U>Leaderf rg --recall<CR>

  let g:Lf_HideHelp = 1
  let g:Lf_UseCache = 0
  let g:Lf_UseVersionControlTool = 0
  let g:Lf_PreviewInPopup = 1
  let g:Lf_WorkingDirectoryMode = 'Ac'
  let g:Lf_WindowHeight = 0.3
  let g:Lf_WindowPosition = 'popup'
  let g:Lf_ShowRelativePath = 1
  let g:Lf_CacheDirectory = expand('~/.vim/cache')
  let g:Lf_StlColorscheme = 'gruvbox_material'
  let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
  let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
  let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
endfunction "}}}


function! s:coc() "{{{
  " When CocList is enabled, use 'o' and '<c-o>' to switch between
  " insert and normal mode. 'ESC' to cancel list.

  let g:coc_disable_transparent_cursor = 1

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_backspace() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  function! s:check_backspace() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction "}}}
  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
  nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nnoremap <silent> gd <Plug>(coc-definition)
  nnoremap <silent> gt <Plug>(coc-type-definition)
  nnoremap <silent> gi <Plug>(coc-implementation)
  nnoremap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nnoremap <leader>rn <Plug>(coc-rename)
  " Remap keys for applying codeAction to the current buffer.
  "nnoremap <leader>ac <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nnoremap <leader>qf <Plug>(coc-fix-current)

  " Formatting selected code.
  "xmap <leader>f <Plug>(coc-format-selected)
  "nmap <leader>f <Plug>(coc-format-selected)

  " Find symbol of current document.
  nnoremap <silent><nowait> <leader>co :<C-u>CocList outline<cr>
  " Resume latest coc list.
  nnoremap <silent><nowait> <leader>cr :<C-u>CocListResume<CR>

endfunction "}}}


" vim:set ft=vim et sw=2:
