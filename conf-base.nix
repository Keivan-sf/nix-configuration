# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, pkgs24, pkgs23, ... }:

{
  imports = [ ./pkgs/custom-pkgs.nix ];
  # home 
  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us,ir";
  #services.xserver.xkb.options = "eurosign:e,caps:escape, grp:shifts_toggle";
  services.xserver.xkb.options = "eurosign:e,caps:escape, grp:win_space_toggle";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.sane.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.keive = {
    isNormalUser = true;
    description = "keive";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "docker" ];
    packages = with pkgs;
      [
        firefox
        #  thunderbird
      ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # fonts
  fonts.packages = with pkgs; [ nerd-fonts.fira-code vazir-fonts corefonts ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    lazygit
    google-chrome
    i3
    qv2ray
    unstable.telegram-desktop
    btop
    libnotify
    pulseaudioFull
    dunst
    killall
    neovim
    gh
    neovide
    libgcc
    gcc9
    mpv
    gnome-disk-utility
    gnome-sound-recorder
    spotify
    xfce.xfce4-pulseaudio-plugin
    pkgs24.gscreenshot
    xclip
    wordnet
    unstable.piper-tts
    pavucontrol
    woeusb
    go
    unstable.nodejs_22
    python3
    v2raya
    unzip
    vscode
    kitty
    gnumake
    deno
    #rocmPackages.llvm.clang
    #rocmPackages.llvm.clang-tools-extra
    clang-tools
    lua
    unstable.lua-language-server
    corepack_22
    nil
    nautilus
    feh
    picom
    ripgrep
    bc
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.svelte-language-server
    insomnia
    nixfmt-classic
    proxychains
    vscode-langservers-extracted
    python311Packages.python-lsp-server
    python311Packages.autopep8
    python3.pkgs.pip
    pyright
    zoxide
    libsForQt5.kget
    expressvpn
    fzf
    nest-cli
    postgresql_16
    dbeaver-bin
    discord
    direnv
    # nodePackages."@prisma/language-server"
    nodePackages.prettier
    prettierd
    openssl
    nodePackages.prisma
    nodePackages.dotenv-cli
    eslint_d
    bun
    lzip
    dpkg
    pgadmin4
    csharp-ls
    dotnet-sdk_8
    ncompress
    codespell
    nodePackages.cspell
    weston
    wireguard-tools
    tree
    gdb
    # nekoray
    pkgs24.nekoray
    stylua
    black
    astyle
    obs-studio
    libsForQt5.kdenlive
    unrar
    tor-browser
    calibre
    ### libs used for guilded
    steam-run
    autoPatchelfHook
    gtk3
    nss # xorg.libXScrnSaver
    xorg.libXtst
    xdg-utils
    at-spi2-atk
    libuuid
    libsecret
    ffmpeg-full
    ffmpeg-headless
    vivaldi-ffmpeg-codecs
    alsa-lib
    ### end libs used for guilded
    gnupg
    pinentry-tty
    age
    wineWowPackages.stableFull
    winetricks
    lutris
    godot_4
    autoconf271
    automake115x
    nasm
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.fa_IR
    vscode-extensions.vadimcn.vscode-lldb
    unstable.cargo
    unstable.rustc
    unstable.rust-analyzer
    unstable.rustfmt
    libsForQt5.okular
    nomacs
    onlyoffice-bin_latest
    unstable.libreoffice-qt6-fresh
    wpsoffice
    virtualenv
    poetry
    niv
    jupyter-all
    glibc
    zip
    neofetch
    pypy3
    alsa-utils
    uv
    electron
    libsForQt5.kcharselect
    docker-compose
    git
    (wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-s3
        helm-git
      ];
    })
    wireshark
    (writeShellScriptBin "xon" ''
      echo "$(nohup nautilus . -w 1>/dev/null 2>/dev/null & exit 1>/dev/null)" | sh'')
    unstable.tailwindcss-language-server
    emmet-ls
    jan
    mkcert
    appimage-run
    mesa-demos
    gimp-with-plugins
    playerctl
    cmus
    yt-dlp
    motrix
    p7zip
    musescore
    openvpn3
    openvpn
    inetutils
    dig
    xray
    llama-cpp
    zellij
    amberol
    v2rayn
    nix-serve-ng
    jq
    node2nix
    iperf
    go
    gopls
    vivaldi
    lsof
    file
    nix-index
    hiddify-app
    pkgs23.sing-box
  ];

  programs.gamemode.enable = true;
  programs.nix-ld.enable = true;

  programs.proxychains = {
    enable = true;
    proxies = {
      prx1 = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 12334;
      };
    };
  };

  # services
  # services.picom.enable = true;
  # services.expressvpn.enable = true;
  programs.openvpn3.enable = true;

  # virtualisation
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    insecure-registries = [ "https://docker.arvancloud.ir" ];
    registry-mirrors = [ "https://docker.arvancloud.ir" ];
  };

  environment.sessionVariables = rec {
    TERMINAL = "kitty";
    DEFAULT_BROWSER = "${pkgs.google-chrome}/bin/google-chrome";
    EDITOR = "${pkgs.neovim}/bin/nvim";
  };

  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # xdg
  xdg.mime.defaultApplications = {
    "inode/directory" = "nautilus";
    "video/x-matroska" = "mpv";
    "x-scheme-handler/http" = "google-chrome.desktop";
    "x-scheme-handler/https" = "google-chrome.desktop";
    "text/html" = "google-chrome.desktop";
    "text/plain" = "neovide";
  };

  xdg.mime.enable = true;

  # systemd.services.my-v2raya = {
  #   script = ''
  #     "${pkgs.v2raya}/bin/v2rayA"
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  #   partOf = [ "multi-user.target" ];
  # };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  #k3s 
  #services.k3s.enable = true;
  #services.k3s.role = "server";
  #services.k3s.extraFlags = toString [
  # "--debug" # Optionally add additional args to k3s
  #];

  environment.etc.genssl = { source = ./dotfiles/nginx/ssl; };

  services.nginx = {
    enable = true;
    # appendHttpConfig = builtins.readFile ./dotfiles/nginx/default.conf;
    virtualHosts."localhost" = {
      forceSSL = true;
      # enableACME = true; # Set to true if using Let's Encrypt
      sslCertificate = "/etc/genssl/localhost.pem";
      sslCertificateKey = "/etc/genssl/localhost-key.pem";

      locations."/" = {
        proxyPass = "http://localhost:1420"; # Change port if needed
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    443
    80
    2080
    2081
    20170
    20171
    5574 # v2ray testers
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
    5001
    5000
    3000 # development
    12334 # hiddify
  ];
  networking.firewall.allowedUDPPorts = [
    8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # dns
  # networking.nameservers = [ "178.22.122.100" "185.51.200.2" ]; # shecan
  # networking.nameservers = [ "172.29.0.100" "172.29.2.100" ]; # hostiran
  networking.nameservers = [ "10.202.10.202" "10.202.10.102" ]; # 403
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
