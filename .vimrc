" load default config
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" settings
set number relativenumber
set expandtab
set shiftwidth=4
set tabstop=4
set ttymouse=sgr
set ignorecase  " case insensitive searching
set smartcase   " but caps
set smartindent
set hlsearch

" packages
packadd! nerdtree
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
    let proj_name = input('Enter project name: ')
    let file_desc = input('Enter file description: ')

    if file_desc == ''
        let file_desc = expand('%:t:r')
    endif
    call append(0, top)
    call append(1, mid . " EPITECH PROJECT, " . strftime("%Y"))
    call append(2, mid . " " . proj_name)
    call append(3, mid . " File description:")
    call append(4, mid . " " . file_desc)
    call append(5, bot)
endfunction

command EpiHeader call EpitechHeader()

" keybindings
nnoremap <F8> :NERDTreeToggle<CR>
nnoremap <C-c><C-h> :EpiHeader<CR>
