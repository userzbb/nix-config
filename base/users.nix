{ pkgs, ... }: {
  users.users."zizimiku" = {
    isNormalUser = true;
    shell = pkgs.zsh; 
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+HH2lnW9jhK8sA+EDWl9ksTu+ERvXl1f7zYFici7VM zizimiku@outlook.com"
    ];
  };

  users.users.root.shell = pkgs.zsh;

  security.sudo.extraRules = [
    {
      users = [ "zizimiku" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
