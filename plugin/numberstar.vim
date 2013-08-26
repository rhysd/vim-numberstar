if exists('g:loaded_numberstar')
    finish
endif

function! s:cursor_number()
    let is_number = '\%(\%(\w\|[]})\"'."'".']\s*\)\@<!-\)\=\%(\<[[:digit:]_]\+\%(\.[[:digit:]_]\+\)\=\%([Ee][[:digit:]_]\+\)\=\>\|\<0[xXbBoOdD][[:xdigit:]_]\+\>\)'
    let [_, col]  = searchpos(is_number, 'bcn', line('.'))
    return matchstr(getline('.')[col -1 : ], is_number)
endfunction

let s:search_command = {'*' : '/', 'g*' : '/', '#' : '?', 'g#' : '?'}

function! s:make_key_sequence(input)
    let number = s:cursor_number()
    if number ==# ''
        return a:input
    else
        if a:input !~# '^g'
            let number = '\%(^\|\<\|\s\+\zs\)'.number.'\>'
        endif
        return s:search_command[a:input].number."\<CR>"
    endif
endfunction

nnoremap <silent><expr><Plug>(number-star-*) <SID>make_key_sequence('*')
nnoremap <silent><expr><Plug>(number-star-#) <SID>make_key_sequence('#')
nnoremap <silent><expr><Plug>(number-star-g*) <SID>make_key_sequence('g*')
nnoremap <silent><expr><Plug>(number-star-g#) <SID>make_key_sequence('g#')

if ! get(g:, 'numberstar_no_default_mappings', 0)
    nmap <silent>* <Plug>(number-star-*)
    nmap <silent># <Plug>(number-star-#)
    nmap <silent>g* <Plug>(number-star-g*)
    nmap <silent>g# <Plug>(number-star-g#)
endif

let g:loaded_numberstar = 1
