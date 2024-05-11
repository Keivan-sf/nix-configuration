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
      update = "sudo nixos-rebuild switch --flake .#pc";
      nv = "neovide";
      xon = "echo \"$(nohup nautilus . 1>/dev/null 2>/dev/null & exit 1>/dev/null)\" | sh";
    };
    history.size = 10000;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "man" "vi-mode" "docker" "docker-compose" ];
      theme = "robbyrussell";
    };
  };
}
