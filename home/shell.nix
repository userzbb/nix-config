{ config, pkgs, ... }: {

home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "robbyrussell";
    };
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      update = "sudo nixos-rebuild switch --flake ~/nix-config#nixos";
    };
    initContent = ''

    '';
  };
}
