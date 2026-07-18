{ ... }: {
  services.samba = {
    enable = false;
    openFirewall = true;
  };
}