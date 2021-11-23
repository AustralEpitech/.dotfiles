""" load default config \"""
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

""" variables \"""
let &path = &path . ',' . getcwd() . '/**'
let g:netrw_liststyle=3 " tree style file explorer
set expandtab
set hlsearch
set ignorecase
set number relativenumber
set shiftwidth=4
set smartcase
set smartindent
set tabstop=4
set ttymouse=sgr
au BufNewFile,BufRead *.c set cc=81
au BufNewFile,BufRead *.h set cc=81

""" packages \"""
packadd! vim-better-whitespace

function! EpitechHeader()
    let com_arr = {
        \ 'c':      {'top': '/*', 'mid': '**', 'bot': '*/'},
        \ 'cpp':    {'top': '/*', 'mid': '**', 'bot': '*/'},
        \ 'make':   {'top': '##', 'mid': '##', 'bot': '##'}
    \ }
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

command EpiHeader call EpitechHeader()

""" keybindings \"""
nnoremap <C-c><C-h> :EpiHeader<CR>
