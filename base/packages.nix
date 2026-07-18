{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    htop
    file
    tree
    unzip
    yazi
  ];
}
