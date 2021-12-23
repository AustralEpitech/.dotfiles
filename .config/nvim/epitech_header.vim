function! EpitechHeader()
    let com_arr = {
        \ 'c':      {'top': '/*', 'mid': '**', 'bot': '*/'},
        \ 'cpp':    {'top': '/*', 'mid': '**', 'bot': '*/'},
        \ 'make':   {'top': '##', 'mid': '##', 'bot': '##'}
    \ }

    if (!has_key(com_arr, &filetype))
        echoerr "Unsupported filetype: " . &filetype
        return
    endif

    let top = com_arr[&filetype]['top']
    let mid = com_arr[&filetype]['mid']
    let bot = com_arr[&filetype]['bot']
    let dir_name = fnamemodify(getcwd(), ':t')
    let proj_name = input('Enter project name (default ' . dir_name . '): ')
    let file_name = expand('%:t:r')
    let file_desc = input('Enter file description (default ' . file_name . '): ')

    if file_desc == ''
        let file_desc = file_name
    endif
    if proj_name == ''
        let proj_name = dir_name
    endif
    call append(0, top)
    call append(1, mid . ' EPITECH PROJECT, ' . strftime('%Y'))
    call append(2, mid . ' ' . proj_name)
    call append(3, mid . ' File description:')
    call append(4, mid . ' ' . file_desc)
    call append(5, bot)
endfunction

command Header call EpitechHeader()
