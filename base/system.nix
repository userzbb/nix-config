{ pkgs, ... }:
let
  githubToken = import ../home/token.nix;
in {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };
  services.xserver.xkb.layout = "us";
  nixpkgs.config.allowUnfree = true;

  # 国内镜像加速
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://cache.nixos.org"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "mirrors.ustc.edu.cn-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];

  # 启用 nix-command 和 flakes（让 nix shell、nix run 等命令正常工作）
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.access-tokens = "github.com=${githubToken}";  # GitHub API 认证，解决 rate limit
  nix.settings.auto-optimise-store = true;  # 自动通过硬链接优化 store，节省磁盘空间

  # nix-sweep: 定期自动清理旧的 profile generations 并 GC
  services.nix-sweep = {
    enable = true;
    interval = "daily";
    keepMin = 3;
    keepMax = 5;
    removeOlder = "14d";
    gc = true;
  };

  # 限制 journal 日志大小，防止 /var/log 占满磁盘
  services.journald.extraConfig = ''
    SystemMaxUse=200M
    MaxRetentionSec=7d
  '';

  # 全局 Zsh
  programs.zsh.enable = true;

  # 将 zizimiku 的配置软链接给其他用户（如 root）
  # 用 systemd oneshot 确保在 home-manager 激活之后执行
  systemd.services.link-root-configs = {
    description = "Link root configs from zizimiku";
    wantedBy = [ "multi-user.target" ];
    after = [ "home-manager-zizimiku.service" ];
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /root /root/.config
      ln -sf /home/zizimiku/.vimrc /root/.vimrc
      ln -sfn /home/zizimiku/.config/yazi /root/.config/yazi
    '';
  };

  system.stateVersion = "26.05";
}
