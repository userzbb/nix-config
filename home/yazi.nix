{ ... }: {
  xdg.configFile."yazi/yazi.toml".text = ''
    [manager]
    show_hidden = true
    sort_by = "natural"
    sort_dir_first = true
    linemode = "size"

    [preview]
    tab_size = 4
    max_width = 800
    max_height = 600

    [opener]
    edit = [
      { run = 'vim "$@"', desc = "Edit with vim", for = "unix" }
    ]

    [open]
    prepend_rules = [
      { name = "*.md", use = "edit" },
      { name = "*.nix", use = "edit" },
      { name = "*.toml", use = "edit" },
      { name = "*.json", use = "edit" },
    ]
  '';

  xdg.configFile."yazi/theme.toml".text = ''
    [status]
    separator_open = ""
    separator_close = ""

    [[status.mode]]
    name = "normal"
    bg = "#89b4fa"
    fg = "#1e1e2e"
    bold = true

    [[status.mode]]
    name = "select"
    bg = "#f9e2af"
    fg = "#1e1e2e"
    bold = true

    [[status.mode]]
    name = "unset"
    bg = "#a6adc8"
    fg = "#1e1e2e"
    bold = true

    [filetype]
    rules = [
      { mime = "image/*", fg = "#89b4fa" },
      { mime = "video/*", fg = "#f9e2af" },
      { mime = "audio/*", fg = "#a6e3a1" },
      { name = "*.md", fg = "#cba6f7" },
      { name = "*.nix", fg = "#89b4fa" },
      { name = "*.toml", fg = "#fab387" },
      { name = "*.json", fg = "#f9e2af" },
      { name = "*.rs", fg = "#fab387" },
      { name = "*.py", fg = "#a6e3a1" },
    ]
  '';

  xdg.configFile."yazi/keymap.toml".text = ''
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
}
