{ ... }: {
  imports = [
    ./c-cpp.nix
    ./python.nix
    ./rust.nix
    ./go.nix
    ./java.nix
  ];
}