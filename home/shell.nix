{ ... }: {

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    http_proxy = "http://192.168.159.1:7897";
    https_proxy = "http://192.168.159.1:7897";
    all_proxy = "socks5://192.168.159.1:7897";
    no_proxy = "localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/8,*.local";
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
      update = "nix flake update && sudo nixos-rebuild switch --flake .#nixos";
    };
    initContent = ''
      nix-shell() {
        if [[ $1 == -p ]]; then
          command nix-shell "$@" --command "exec zsh"
        else
          command nix-shell "$@"
        fi
      }
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        command yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d $'\0' cwd < "$tmp"
        [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
        command rm -f -- "$tmp"
      }
    '';
  };
}
