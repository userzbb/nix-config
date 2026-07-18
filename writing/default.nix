{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pandoc
    typst
    texliveFull
    zotero
  ];
}