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
  echom '[getpr.vim]' a:msg
  echohl None
endfunction

function! s:get_url() abort
  if !executable('getpr')
    call s:echo('not found "getpr" in your PATH, please install from https://github.com/skanehira/getpr')
    return
  endif
  let file = expand('%s')
  if empty(file)
    call s:echo('file name is empty')
    return
  endif
  let line = line('.')
  let blame_line = system(printf('git blame -L %s,%s -- %s', line, line, file))

  if blame_line =~ 'fatal\|usage'
    call s:echo(blame_line)
    return
  endif
  if empty(blame_line)
    call s:echo('[getpr.vim] cannot get commit id')
    return
  endif
  let id = blame_line->split(' ')[0]
  if id =~ '\^.*'
    let id = id->trim('^')
  endif
  let url = system(printf('%s %s', 'getpr', id))->trim()
  if url =~ 'found\|cannot'
    call s:echo(url)
    return
  endif
  return url
endfunction

function! getpr#open() abort
  let url = s:get_url()
  if empty(url)
    return
  endif
  call system(printf('%s %s', s:cmd, url))
endfunction

function! getpr#yank() abort
  let url = s:get_url()
  if empty(url)
    return
  endif
  let reg = '*'
  if has('linux')
    let reg = '+'
  endif
  call setreg(reg, url)
  echom 'copied' url
endfunction
