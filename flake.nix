{
  description = "My NixOS config with VS Code remote and AI tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cc-switch-cli = {
      url = "github:SaladDay/cc-switch-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-yazi = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };
    catppuccin-yazi-themes = {
      url = "github:catppuccin/yazi";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos/configuration.nix
        ];
      };
    };
  };
}
