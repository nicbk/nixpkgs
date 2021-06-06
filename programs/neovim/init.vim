set termguicolors

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:onedark_terminal_italics = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'minimalist'

let g:AutoPairs = { '(':')', '[':']', '{':'}' }

set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamedplus

autocmd VimResized * wincmd =
autocmd Filetype html setlocal ts=2 sts=2 sw=2 et
autocmd Filetype css setlocal ts=2 sts=2 sw=2 et
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 et
autocmd Filetype javascriptreact setlocal ts=2 sts=2 sw=2 et
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2 et
autocmd Filetype typescriptreact setlocal ts=2 sts=2 sw=2 et
autocmd Filetype json setlocal ts=2 sts=2 sw=2 et

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

nmap <silent> <c-p> :tabp<CR>
nmap <silent> <c-n> :tabn<CR>

map <leader>s <Plug>(easymotion-s)
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :GFiles<CR>

colorscheme onedark
autocmd vimenter * hi Normal ctermbg=NONE guibg=NONE
autocmd vimenter * hi NonText ctermbg=NONE guibg=NONE
