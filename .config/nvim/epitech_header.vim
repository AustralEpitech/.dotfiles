function! EpitechHeader(ft=&filetype)
    let com_arr = {
        \ 'c':       {'top': '/*', 'mid': '**', 'bot': '*/'},
        \ 'cpp':     {'top': '/*', 'mid': '**', 'bot': '*/'},
        \ 'make':    {'top': '##', 'mid': '##', 'bot': '##'},
        \ 'haskell': {'top': '{-', 'mid': '--', 'bot': '-}'},
    \ }

    if (!has_key(com_arr, a:ft))
        echoerr "Unsupported filetype: " . a:ft
        return
    endif

    let top = com_arr[a:ft]['top']
    let mid = com_arr[a:ft]['mid']
    let bot = com_arr[a:ft]['bot']
    let dir_name = fnamemodify(getcwd(), ':t')
    let file_name = expand('%:t:r')

    call append(0, top)
    call append(1, mid . ' EPITECH PROJECT, ' . strftime('%Y'))
    call append(2, mid . ' ' . dir_name)
    call append(3, mid . ' File description:')
    call append(4, mid . ' ' . file_name)
    call append(5, bot)
endfunction

command Header call EpitechHeader()
