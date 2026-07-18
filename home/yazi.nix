{ catppuccin-yazi, catppuccin-yazi-themes, ... }: let
  flavor = "${catppuccin-yazi}/catppuccin-mocha.yazi";
in {
  xdg.configFile = {
    "yazi/flavors/catppuccin-mocha.yazi".source = flavor;
    "yazi/theme.toml".source = "${catppuccin-yazi-themes}/themes/mocha/catppuccin-mocha-pink.toml";
    "yazi/Catppuccin-mocha.tmTheme".source = "${flavor}/tmtheme.xml";
  };
}
