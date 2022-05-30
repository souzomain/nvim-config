" insert mode
imap <C-s> <C-o>:w<CR>
imap <C-z> <C-o>:undo<CR>

" normal mode
nmap <C-o> :NERDTreeToggle <CR>
"nmap <silent> ;f :call CocAction('format') <CR>
"nmap <silent> ;d <Plug>(coc-definition)
"nmap <silent> ;b <Plug>(coc-diagnostic-prev)
"nmap <silent> ;n <Plug>(coc-diagnostic-next)
nmap <silent> ]f :FZF <CR>
vmap <Tab> >gv
vmap <S-tab> <gv

nmap <C-s> :w <CR>

" auto-complete 
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

"autocmd CursorHold * silent call CocActionAsync('highlight')
