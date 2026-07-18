{ ... }: {
  # nvm — Node 版本管理，自动安装 Node 22 LTS
  programs.nvm.enable = true;
  programs.nvm.nodeVersion = "22";
}