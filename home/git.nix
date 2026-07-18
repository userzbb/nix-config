{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "zizimiku";
    userEmail = "zizimiku@outlook.com";
  };
}
