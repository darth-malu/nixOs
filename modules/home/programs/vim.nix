{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      # dracula-vim
      # embark-vim
      # gruvbox
      # neodark-vim
      # nightfly
      # nord-vim
      # vim-airline
      ale
      gruvbox-material
      nerdtree
      onedark-vim
      vim-commentary
      vim-fugitive
    ];
    extraConfig = # .vimrc
      ''
        colorscheme onedark
        " set relativenumber
        set number
        set shiftwidth=2
        set tabstop=2
        set cursorline
        syntax on

        " Differnt cursor for different mode"
        set guicursor=n-v-c:block,i:ver25,r:hor20

        " Disable compatibility with vi which can cause unexpected issues.
        set nocompatible

        " Enable type file detection. Vim will be able to try to detect the type of file is use.
        filetype on

        " Enable plugins and load plugin for the detected file type.
        filetype plugin on

        " Load an indent file for the detected file type.
        filetype indent on

        " spaces instead of tabs
        set expandtab

        " Do not save backup files.
        set nobackup

        " Pressing the letter o will open a new line below the current one.
        " Exit insert mode after creating a new line above or below the current line.
        " nnoremap o o<esc>
        " nnoremap O O<esc>

        " Map the F5 key to run a Python script inside Vim.
        " We map F5 to a chain of commands here.
        " :w saves the file.
        " <CR> (carriage return) is like pressing the enter key.
        " !clear runs the external clear screen command.
        " !python3 % executes the current file with Python.
        " nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

        " You can split the window in Vim by typing :split or :vsplit.
        " Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
        nnoremap <c-j> <c-w>j
        nnoremap <c-k> <c-w>k
        nnoremap <c-h> <c-w>h
        nnoremap <c-l> <c-w>l

        " Resize split windows using arrow keys by pressing:
        " CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
        noremap <c-up> <c-w>+
        noremap <c-down> <c-w>-
        noremap <c-left> <c-w>>
        noremap <c-right> <c-w><

        " NERDTree specific mappings.
        " Map the _ key to toggle NERDTree open and close.
        nnoremap <_> :NERDTreeToggle<cr>

        " Have nerdtree ignore certain files and directories.
        let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

        set scrolloff=10

        " While searching though a file incrementally highlight matching characters as you type.
        set incsearch

        " Ignore capital letters during search.
        set ignorecase

        " Override the ignorecase option if searching for capital letters.
        " This will allow you to search specifically for capital letters.
        set smartcase

        " Show partial command you type in the last line of the screen.
        set showcmd

        " Show the mode you are on the last line.
        set showmode

        " Show matching words during a search. - parantheses
        " set showmatch

        " Use highlighting when doing a search.
        set hlsearch

        " Set the commands to save in history default number is 20.
        set history=1000

        " Enable auto completion menu after pressing TAB.
        set wildmenu

        " Make wildmenu behave like similar to Bash completion.
        " set wildmode=list:longest

        " There are certain files that we would never want to edit with Vim.
        " Wildmenu will ignore files with these extensions.
        set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

        " Keybindds
        " nnoremap <leader>\ :nohlsearch<CR>
      '';
  };
}
