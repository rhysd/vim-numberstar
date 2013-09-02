function! s:cursor_number()
    let is_number = '\%(\%(\w\|[]})\"'."'".']\s*\)\@<!-\)\=\%(\<[[:digit:]_]\+\%(\.[[:digit:]_]\+\)\=\%([Ee][[:digit:]_]\+\)\=\>\|\<0[xXbBoOdD][[:xdigit:]_]\+\>\)'
    let [_, col]  = searchpos(is_number, 'bcn', line('.'))
    return matchstr(getline('.')[col -1 : ], is_number)
endfunction

let s:search_command = {'*' : '/', 'g*' : '/', '#' : '?', 'g#' : '?'}

function! numberstar#key(input)
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

