{ ... }: {
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  xdg.configFile."neovide/config.toml".source = ./dotfiles/neovide/config.toml;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -la";
      nv = "neovide";
      xon = "echo \"$(nohup nautilus . -w 1>/dev/null 2>/dev/null & exit 1>/dev/null)\" | sh";
    };
    history.size = 10000;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "python" "man" "vi-mode" "docker" "docker-compose" ];
      theme = "robbyrussell";
    };
  };
}
