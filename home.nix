{ ... }: {
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  xdg.configFile."i3/config".source = ./dotfiles/i3/pc;
  xdg.configFile."i3/i3-volume.sh".source = ./dotfiles/i3/i3-volume.sh;
}