{ ... }: {
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      " === 外观 ===
      set number
      set relativenumber
      set cursorline
      set showmode
      set showcmd
      set ruler

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
      set history=1000
      set undolevels=1000
      set undofile
      set undodir=~/.vim/undo
    '';
  };

  # 为 root 创建软链接，共享同一份 vim 配置
  home.activation.linkVimForRoot = ''
    if [ "$USER" = "zizimiku" ]; then
      $DRY_RUN_CMD sudo mkdir -p /root
      $DRY_RUN_CMD sudo ln -sf /home/zizimiku/.vimrc /root/.vimrc
    fi
  '';
}