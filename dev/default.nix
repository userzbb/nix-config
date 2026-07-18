{ ... }: {
  imports = [
    ./languages/default.nix
    ./containers/default.nix
    ./remote/vscode-server.nix
  ];
}