{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # 基础工具
    vim
    git
    curl
    wget
    file
    tree
    unzip
    jq

    # 系统监控
    htop
    btop
    bottom
    zenith
    gotop
    glances
    fastfetch

    # 文件管理
    yazi
    ffmpegthumbnailer
    unar
    poppler-utils
    fd
    ripgrep
  ];
}
