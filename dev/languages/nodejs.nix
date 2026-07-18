{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodejs
    bun
    pnpm
    yarn
  ];
}