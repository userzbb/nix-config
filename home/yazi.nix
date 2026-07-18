{ catppuccin-yazi, catppuccin-yazi-themes, ... }: {
  xdg.configFile = {
    # catppuccin-mocha flavor (提供 tmtheme.xml 语法高亮)
    "yazi/flavors/catppuccin-mocha.yazi".source = "${catppuccin-yazi}/catppuccin-mocha.yazi";

    # catppuccin-mocha-pink 主题
    "yazi/theme.toml".source = "${catppuccin-yazi-themes}/themes/mocha/catppuccin-mocha-pink.toml";

    # tmTheme 语法高亮文件 (pink 主题引用此路径)
    "yazi/Catppuccin-mocha.tmTheme".source = "${catppuccin-yazi}/catppuccin-mocha.yazi/tmtheme.xml";
    
  };
}
