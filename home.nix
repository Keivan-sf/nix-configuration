{ ... }: {
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  xdg.configFile."i3/config".source = ./dotfiles/i3/pc;
  xdg.configFile."i3/i3-volume".source = ./dotfiles/i3/i3-volume;
  xdg.configFile."neovide/config.toml".source = ./dotfiles/neovide/config.toml;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flakes #.pc";
    };
    history.size = 10000;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" "vi-mode" "docker" "docker-compose" ];
      theme = "robbyrussell";
    };
  };
}
