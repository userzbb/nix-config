{ inputs, pkgs, ... }: {
  environment.systemPackages = [ inputs.cc-switch-cli.packages.${pkgs.system}.cc-switch ];
}
