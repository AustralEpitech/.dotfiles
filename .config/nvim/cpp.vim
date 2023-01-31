function! CppHeader()
    let file_name = expand('%:t:r')

    call EpitechHeader('cpp')
    call append(7, '#include "' .. file_name .. '.hpp"')
endfunction

function! HppHeader()
    let file_name = expand('%:t:r')

    call EpitechHeader('cpp')
    call append(7, '#pragma once')
    call append(8, '')
    call append(9, 'class ' .. file_name .. ' {')
    call append(10, '    public:')
    call append(11, '        '   .. file_name .. '(void);')
    call append(12, '        ~'  .. file_name .. '(void);')
    call append(13, '')
    call append(14, '    protected:')
    call append(15, '};')
endfunction

au BufNewFile *.cpp call CppHeader()
au BufNewFile *.hpp call HppHeader()
