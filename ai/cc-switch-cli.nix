{ pkgs, ... }:
let
  cc-switch-cli = pkgs.writeShellScriptBin "cc-switch-cli" ''
    ${pkgs.nodejs}/bin/npx cc-switch-cli "$@"
  '';
in {
  environment.systemPackages = [ cc-switch-cli ];
}
