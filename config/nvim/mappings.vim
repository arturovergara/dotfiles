let mapleader = ","

" My custom mappings
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

" Open NERDTree with ALT + SHIFT + Q
map <A-Q> :NvimTreeToggle<CR>

" Find files using Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Mappings to go to buffers
nnoremap <leader>1 <cmd>BufferGoto 1<cr>
nnoremap <leader>2 <cmd>BufferGoto 2<cr>
nnoremap <leader>3 <cmd>BufferGoto 3<cr>
nnoremap <leader>4 <cmd>BufferGoto 4<cr>
nnoremap <leader>5 <cmd>BufferGoto 5<cr>
nnoremap <leader>6 <cmd>BufferGoto 6<cr>
nnoremap <leader>7 <cmd>BufferGoto 7<cr>
nnoremap <leader>8 <cmd>BufferGoto 8<cr>
nnoremap <leader>9 <cmd>BufferGoto 9<cr>
nnoremap <leader>0 <cmd>BufferLast<cr>

" Mappings to delete buffers
nnoremap <Leader>dd <cmd>BufferClose<CR>
" nmap <Leader>d1 <Plug>lightline#bufferline#delete(1)
" nmap <Leader>d2 <Plug>lightline#bufferline#delete(2)
" nmap <Leader>d3 <Plug>lightline#bufferline#delete(3)
" nmap <Leader>d4 <Plug>lightline#bufferline#delete(4)
" nmap <Leader>d5 <Plug>lightline#bufferline#delete(5)
" nmap <Leader>d6 <Plug>lightline#bufferline#delete(6)
" nmap <Leader>d7 <Plug>lightline#bufferline#delete(7)
" nmap <Leader>d8 <Plug>lightline#bufferline#delete(8)
" nmap <Leader>d9 <Plug>lightline#bufferline#delete(9)
" nmap <Leader>dw :bw<CR>
