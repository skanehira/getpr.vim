" getpr
" Author: skanehira
" License: MIT

if exists('loaded_getpr')
  finish
endif
let g:loaded_getpr = 1

command! GetprOpen call getpr#open()
command! GetprYank call getpr#yank()

nnoremap <silent> <Plug>(getpr-open) :call getpr#open()<CR>
nnoremap <silent> <Plug>(getpr-yank) :call getpr#yank()<CR>
