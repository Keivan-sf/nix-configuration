{ pkgs, self, ... }: {
  home.packages = with pkgs; [ adw-gtk3 materia-theme ];
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  xdg.configFile."kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
  xdg.configFile."picom/picom.conf".source = ./dotfiles/picom/picom.conf;

  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(zoxide init zsh)"
      export PATH="/home/keive/.local/bin:/home/keive/.cargo/bin:$PATH"
    '';
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -la";
      nv = "neovide --fork";
      # There is a reason you piped it to the sh, There is an extra annoying log
      #pupdate = "(" + builtins.readFile ./scripts/pupdate.sh + ")";
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
