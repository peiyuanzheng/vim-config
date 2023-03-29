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
  " 搜索当前项目目录最近打开的文件
  noremap <m-o> :Leaderf mru --project<cr>
  " 搜索全局最近打开的文件 (u:used)
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

  " gtags
  " 搜索当前光标下字符串的引用
  noremap <leader>fr :<C-U><C-R>=printf("Leaderf gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
  " 搜索当前光标下字符串的定义
  noremap <leader>fd :<C-U><C-R>=printf("Leaderf gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
  " 打开最近一次的搜索结果
  noremap <leader>fo :<C-U><C-R>=printf("Leaderf gtags --recall %s", "")<CR><CR>
  " 跳转到最近一次的搜索结果的下一条
  noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
  " 跳转到最近一次的搜索结果的上一条
  noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

  let g:Lf_HideHelp = 1
  let g:Lf_FollowLinks = 1
  let g:Lf_UseMemoryCache = 1
  let g:Lf_UseCache = 1
  let g:Lf_UseVersionControlTool = 0
  let g:Lf_PreviewInPopup = 1
  let g:Lf_WorkingDirectoryMode = 'Ac'
  let g:Lf_WindowHeight = 0.3
  "let g:Lf_WindowPosition = 'popup'
  let g:Lf_ShowRelativePath = 1
  "let g:Lf_CacheDirectory = expand('~/.vim/cache')
  let g:Lf_StlColorscheme = 'gruvbox_material'
  let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
  let g:Lf_RootMarkers = ['.root']
  let g:Lf_PreviewResult = {'Function':1, 'BufTag':1, 'Rg':1, 'Gtags':1}

  let g:Lf_GtagsAutoGenerate = 1 " 生成的 tags 目录: $HOME/.LfCache/gtags/
  let g:Lf_GtagsSkipUnreadable = 1
  let g:Lf_GtagsHigherThan6_6_2 = 0 " 不跳过 symlink; 可在 $HOME/.globalrc 中添加文件黑名单
endfunction "}}}


function! s:check_backspace() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction "}}}


function! s:coc() "{{{
  " When CocList is enabled, use 'o' and '<c-o>' to switch between
  " insert and normal mode. 'ESC' to cancel list.

  let g:coc_disable_transparent_cursor = 1

  " Use tab for trigger completion with characters ahead and navigate
  " NOTE: There's always complete item selected by default, you may want to enable
  " no select by `"suggest.noselect": true` in your configuration file
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ <SID>check_backspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
  nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nnoremap <silent> ge <Plug>(coc-definition)
  nnoremap <silent> gt <Plug>(coc-type-definition)
  nnoremap <silent> gi <Plug>(coc-implementation)
  nnoremap <silent> gr <Plug>(coc-references)

  call <SID>coc_ccls()

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
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


function! s:coc_ccls() "{{{
  " bases
  nnoremap <silent> <leader>jb :call CocLocations('ccls','$ccls/inheritance')<cr>
  " bases of up to 3 levels
  nnoremap <silent> <leader>jB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
  " derived
  nnoremap <silent> <leader>jd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
  " derived of up to 3 levels
  nnoremap <silent> <leader>jD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>
  " caller
  nnoremap <silent> <leader>jc :call CocLocations('ccls','$ccls/call')<cr>
  " callee
  nnoremap <silent> <leader>jC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>
  " member variables / variables in a namespace
  nnoremap <silent> <leader>jm :call CocLocations('ccls','$ccls/member')<cr>
  " member functions / functions in a namespace
  nnoremap <silent> <leader>jf :call CocLocations('ccls','$ccls/member',{'kind':3})<cr>
  " nested classes / types in a namespace
  nnoremap <silent> <leader>js :call CocLocations('ccls','$ccls/member',{'kind':2})<cr>
endfunction "}}}


" vim:set ft=vim et sw=2:
