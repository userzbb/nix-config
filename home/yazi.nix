{ ... }: {
  # 不重复配置，仅将 ~/.config/yazi 符号链接到系统级 /etc/yazi
  # base/yazi.nix 是唯一配置来源，root 和其他用户都通过 /etc/yazi 共享
  home.activation.linkYaziConfig = ''
    if [ ! -e "$HOME/.config/yazi" ] && [ -d /etc/yazi ]; then
      mkdir -p "$HOME/.config"
      ln -sfn /etc/yazi "$HOME/.config/yazi"
    fi
  '';
}
