{ ... }: {
  # 为所有用户设置全局代理环境变量（如果你希望只为自己设，可移到 home/shell.nix）
  environment.variables = {
    http_proxy  = "http://192.168.159.1:7897";
    https_proxy = "http://192.168.159.1:7897";
    all_proxy   = "socks5://192.168.159.1:7897";
    no_proxy    = "localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/8,*.local";
  };

  # 让 nix-daemon 下载包时也走代理（需配合 systemd）
  systemd.services.nix-daemon.serviceConfig.Environment = [
    "http_proxy=http://192.168.159.1:7897"
    "https_proxy=http://192.168.159.1:7897"
  ];

}
