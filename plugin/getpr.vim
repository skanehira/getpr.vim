" getpr
" Author: skanehira
" License: MIT

if exists('loaded_getpr')
  finish
endif
let g:loaded_getpr = 1

let s:cmd = 'open'
if has('linux')
  let s:cmd = 'xdg-open'
elseif has('win64')
  let s:cmd = 'cmd /c start'
endif

function! s:open_pr() abort
  let file = expand('%s')
  let line = line('.')
  let blame_line = system(printf('git blame -L %s,%s -- %s', line, line, file))
  if empty(blame_line)
    echom '[getpr.vim] cannot get commit id'
    return
  endif
  let id = blame_line->split(' ')[0]
  let url = system(printf('%s %s', 'getpr', id))
  call system(printf('%s %s', s:cmd, url))
endfunction

nnoremap <silent> <Plug>(getpr-open) :call <SID>open_pr()<CR>
