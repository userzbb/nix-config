{ ... }: {
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "server min protocol" = "SMB3_00";
      };
      home = {
        path = "/home";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}