{ catppuccin-yazi, ... }: {
  xdg.configFile = {
    # catppuccin-mocha 主题 flavor
    "yazi/flavors/catppuccin-mocha.yazi".source = "${catppuccin-yazi}/catppuccin-mocha.yazi";

    "yazi/yazi.toml".text = ''
      [manager]
      show_hidden = true
      sort_by = "natural"
      sort_dir_first = true
      linemode = "size"

      [preview]
      tab_size = 4
      max_width = 800
      max_height = 600
      cache_dir = ""

      [opener]
      edit = [
        { run = 'vim "$@"', desc = "Edit with vim", for = "unix" }
      ]

      [open]
      prepend_rules = [
        { mime = "text/*", use = "edit" },
      ]

      [tasks]
      shell_mark = { yellow = true, bold = true }
    '';

    "yazi/theme.toml".text = ''
      [flavor]
      use = "catppuccin-mocha"
    '';

    "yazi/keymap.toml".text = ''
      [[manager.prepend_keymap]]
      on = [ "g", "d" ]
      run = "cd ~/nix-config"
      desc = "Go to nix-config"

      [[manager.prepend_keymap]]
      on = [ "g", "h" ]
      run = "cd ~"
      desc = "Go home"

      [[manager.prepend_keymap]]
      on = [ "Z" ]
      run = "quit"
      desc = "Quit yazi"
    '';
  };
}
