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

colorscheme tomorrow-night-bright
" slight blue color
hi CursorLine guibg=#121129
hi Visual guibg=#232249
hi Search guibg=#9999ee
" so apparently bg/fg are reversed for inc search
hi IncSearch guibg=#0000ff
hi IncSearch guifg=#9999ee
hi Cursor guibg=#333399
hi Cursor guifg=#ffffff
