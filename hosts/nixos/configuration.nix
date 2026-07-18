{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix   # 下一步会生成 / 复制到这里
    ../../base/default.nix
    ../../host-services/ssh.nix
    ../../dev/remote/vscode-server.nix
    ../../ai/default.nix
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.zizimiku = {
        imports = [ ../../home/default.nix ];
        home.stateVersion = "26.05";
      };
    }
  ];

 # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;
  # Use provided UUIDs instead of blkid probing (required for btrfs subvolumes)
  boot.loader.grub.fsIdentifier = "provided";


  networking.hostName = "nixos";
  services.qemuGuest.enable = true;   # 保留你原先的虚拟机优化
}
