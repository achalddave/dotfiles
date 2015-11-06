" Remove gvim's ugly toolbar and menu
set guioptions-=T
set guioptions-=m

noremap <C-S-tab> :tabprevious<CR>
noremap <C-tab> :tabnext<CR>
noremap <C-t> :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>a
inoremap <C-tab> <Esc>:tabnext<CR>a
inoremap <C-t> <Esc>:tabnew<CR>a

" Guifontpp
let guifontpp_smaller_font_map="<Leader>-"
let guifontpp_larger_font_map="<Leader>="
let guifontpp_original_font_map="<>"

" Start off in home directory by default
cd $HOME
