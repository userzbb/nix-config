{ ... }: {
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      " === 外观 ===
      set number
      set relativenumber
      set showmode

      " === 缩进 ===
      set expandtab
      set shiftwidth=4
      set tabstop=4
      set softtabstop=4
      set autoindent
      filetype indent on

      " === 搜索 ===
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase

      " === 行为 ===
      set mouse=a
      set hidden
      set undofile
      set undodir=~/.vim/undo
    '';
  };
}
