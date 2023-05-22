function! TekHeader(ft=&filetype)
    let com_arr = {
        \ 'c':       {'top': '/*', 'mid': '**', 'bot': '*/'},
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

function! TekHHeader()
    call TekHeader('c')
    call append(6, '')
    call append(7, '#pragma once')
    call append(8, '')
endfunction

function! TekHppHeader()
    let file_name = expand('%:t:r')

    call append(0, '#pragma once')
    call append(1, '')
    call append(2, 'class ' .. file_name .. ' {')
    call append(3, '    public:')
    call append(4, '        '   .. file_name .. '(void);')
    call append(5, '        ~'  .. file_name .. '(void);')
    call append(6, '')
    call append(7, '    protected:')
    call append(8, '};')
endfunction

au BufNewFile *.c      call TekHeader('c')
au BufNewFile *.hs     call TekHeader('haskell')
au BufNewFile Makefile call TekHeader('make')

au BufNewFile *.h   call TekHHeader()
au BufNewFile *.hpp call TekHppHeader()

command Header call TekHeader()
