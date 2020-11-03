" getpr
" Author: skanehira
" License: MIT

let s:cmd = 'open'
if has('linux')
  let s:cmd = 'xdg-open'
elseif has('win64')
  let s:cmd = 'cmd /c start'
endif

function! s:echo(msg) abort
  echohl ErrorMsg
  echom a:msg
  echohl None
endfunction

function! s:get_url() abort
  let file = expand('%s')
  if empty(file)
    call s:echo('[getpr.vim] file name is empty')
    return
  endif
  let line = line('.')
  let blame_line = system(printf('git blame -L %s,%s -- %s', line, line, file))->trim()

  if blame_line =~ 'fatal\|usage'
    call s:echo('[getpr.vim] ' .. blame_line)
    return
  endif
  if empty(blame_line)
    call s:echo('[getpr.vim] cannot get commit id')
    return
  endif
  let id = blame_line->split(' ')[0]
  let url = system(printf('%s %s', 'getpr', id))
  return url
endfunction

function! getpr#open() abort
  let url = s:get_url()
  if empty(url)
    return
  endif
  call system(printf('%s %s', s:cmd, url))
endfunction
