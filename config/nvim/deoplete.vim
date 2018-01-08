let g:deoplete#enable_at_startup = 1

" Cycle though suggestion in deoplete with only tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
