{ lib, ... }: {
  services.cockpit = {
    enable = true;
    openFirewall = true;
    settings = {
      WebService = {
        Origins = lib.mkForce "https://192.168.159.129:9090 https://localhost:9090";
      };
    };
  };
}