function! EpitechHeader()
    let com_arr = {
        \ 'c':       {'top': '/*', 'mid': '**', 'bot': '*/'},
        \ 'cpp':     {'top': '/*', 'mid': '**', 'bot': '*/'},
        \ 'make':    {'top': '##', 'mid': '##', 'bot': '##'},
        \ 'haskell': {'top': '{-', 'mid': '--', 'bot': '-}'},
    \ }

    if (!has_key(com_arr, &filetype))
        echoerr "Unsupported filetype: " . &filetype
        return
    endif

    let top = com_arr[&filetype]['top']
    let mid = com_arr[&filetype]['mid']
    let bot = com_arr[&filetype]['bot']
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
