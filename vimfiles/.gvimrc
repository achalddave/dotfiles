" Remove gvim's ugly toolbar and menu
set guioptions-=T
set guioptions-=m

" Courier New sucks
set guifont=Consolas

:noremap <C-S-tab> :tabprevious<CR>
:noremap <C-tab> :tabnext<CR>
:noremap <C-t> :tabnew<CR>
:inoremap <C-S-tab> <Esc>:tabprevious<CR>a
:inoremap <C-tab> <Esc>:tabnext<CR>a
:inoremap <C-t> <Esc>:tabnew<CR>a
colorscheme tomorrownight
