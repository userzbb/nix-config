{ ... }: {
  services.samba = {
    enable = false;
    openFirewall = false;
  };
}