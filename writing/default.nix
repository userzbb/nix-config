{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pandoc
    typst
    tinymist
    texliveFull
    zotero
  ];
}