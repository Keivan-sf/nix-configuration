{ ... }: {
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  xdg.configFile."i3/config".source = ./dotfiles/i3/pc;
}
