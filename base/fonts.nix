{ pkgs, ... }:
let
  fontDir = /home/zizimiku/Documents/WrongBook/Fonts;
in {
  fonts.packages = [
    (pkgs.stdenv.mkDerivation {
      name = "zizimiku-custom-fonts";
      src = fontDir;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp *.TTF $out/share/fonts/truetype/ 2>/dev/null || true
        mkdir -p $out/share/fonts/opentype
        cp *.otf $out/share/fonts/opentype/ 2>/dev/null || true
      '';
    })
  ];
}
