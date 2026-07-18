{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    htop
    file
    tree
    unzip
    fastfetch
    yazi
    ffmpegthumbnailer
    unar
    poppler-utils
    fd
    ripgrep
    jq
  ];
}
