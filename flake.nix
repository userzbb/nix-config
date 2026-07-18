{
  description = "My NixOS config with VS Code remote and AI tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };
    catppuccin-yazi = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, vscode-server, ... }@inputs: {
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
