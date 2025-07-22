{ pkgs, self, ... }: {
  home.packages = with pkgs; [ adw-gtk3 materia-theme ];
  home.stateVersion = "22.05";
  home.enableNixpkgsReleaseCheck = false;
  programs.home-manager.enable = true;

  xdg.configFile."kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
  xdg.configFile."picom/picom.conf".source = ./dotfiles/picom/picom.conf;
  xdg.configFile."zellij/dev-layout.kdl".source =
    ./dotfiles/zellij/dev-layout.kdl;
  xdg.configFile."zellij/config.kdl".source = ./dotfiles/zellij/config.kdl;
  xdg.configFile."i3/i3-music-control".source = ./dotfiles/i3/i3-music-control;

  programs.zsh = {
    enable = true;
    initContent = ''
      eval "$(zoxide init zsh)"
      export PATH="/home/keive/.local/bin:/home/keive/.cargo/bin:$PATH"
    '';
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -la";
      nv = "neovide --fork";
      zv = "zellij -l ~/.config/zellij/dev-layout.kdl";
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
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };
  # programs.git = {
  #   enable = true;
  #   userName = "keivan-sf";
  #   userEmail = "keyvan0082@gmail.com";
  # };
}
