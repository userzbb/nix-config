{ ... }: {
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set shiftwidth=2
      set tabstop=2
      set smartindent
    '';
  };
}