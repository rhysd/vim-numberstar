function! s:cursor_number()
    let is_number = '\%(\%(\w\|[]})\"'."'".']\s*\)\@<!-\)\=\%(\<[[:digit:]_]\+\%(\.[[:digit:]_]\+\)\=\%([Ee][[:digit:]_]\+\)\=\>\|\<0[xXbBoOdD][[:xdigit:]_]\+\>\)'
    let [_, col]  = searchpos(is_number, 'bcn', line('.'))
    let line = getline('.')
    let begin = match(line, is_number, col-1)
    let end = matchend(line, is_number, col-1)
    let cursor = col('.') - 1
    if begin == -1 || end == -1 || ! (begin <= cursor && cursor <= end)
        return ''
    endif
    return matchstr(line, is_number, col-1)
endfunction

let s:search_command = {'*' : '/', 'g*' : '/', '#' : '?', 'g#' : '?'}

function! numberstar#key(input)
    if ! has_key(s:search_command, a:input)
        echoerr 'numberstar#key() got wrong input'
        return ''
    endif

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

