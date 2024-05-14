{ pkgs,... }: {
  home.packages = with pkgs; [
    adw-gtk3
    materia-theme
  ];
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
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        prefer-color-scheme = "dark";
      };
    };
  };
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    theme = {
      name="adw-gtk3-dark";
    };
  };
  programs.git = {
    enable = true;
    userName = "keivan-sf";
    userEmail = "keyvan0082@gmail.com";
  };
}
