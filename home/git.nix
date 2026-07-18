{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "zizimiku";
        email = "zizimiku@outlook.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
    };
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
    };
  };
}
