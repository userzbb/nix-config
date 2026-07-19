{ pkgs, ... }: {
  # nix-ld: 让 NixOS 能运行预编译的 Linux 二进制（nvm Node、第三方工具等）
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib  # libstdc++
    zlib
    openssl
  ];
}