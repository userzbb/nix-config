{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    clang
    cmake
    gnumake
    gdb
  ];
}