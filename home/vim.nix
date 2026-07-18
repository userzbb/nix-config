{ ... }: {
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set shiftwidth=4
      set tabstop=4
      set smartindent
    '';
  };
}