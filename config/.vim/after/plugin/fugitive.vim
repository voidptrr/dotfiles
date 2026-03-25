if !exists(':Git')
  finish
endif

nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gm :Git commit<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gP :Git pull<CR>
nnoremap <silent> <leader>gl :Git log --oneline --decorate --graph<CR>
nnoremap <silent> <leader>gd :Gvdiffsplit<CR>
