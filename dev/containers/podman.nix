{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    lazyjournal
    podman-compose
  ];
}
