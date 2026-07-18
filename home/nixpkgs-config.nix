{ config, pkgs, ... }: {
  xdg.configFile."nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
}
