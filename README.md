# getpr.vim
Get GitHub's pull request url.

## Features
- yank/open pull request url

## Installtion
1. Install [getpr](https://github.com/skanehira/getpr) and set your GitHub token.
2. Install this plugin.

e.g [dein.vim](https://github.com/Shougo/dein.vim)

```toml
[[plugin]]
repo = 'skanehira/getpr.vim'
```

## Usage
```vim
" open pull request url
:GetprOpen

" yank pull request url
:GetprYank
```
