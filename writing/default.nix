{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pandoc
    typst
  ];
}