# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, pkgs25, pkgs24, pkgs23, ... }:

{
  imports = [ ./pkgs/custom-pkgs.nix ];
  # home 
  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = true;

  nixpkgs.config.permittedInsecurePackages = [ "mbedtls-2.28.10" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant

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

  services.udev.extraRules = ''
    # BBC micro:bit CMSIS-DAP debug probe
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="0666", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="0d28", ATTRS{idProduct}=="0204", MODE="0666", TAG+="uaccess"
  '';

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.i3.enable = true;
  # services.gnome.gnome-keyring.enable = true;
  security.pam.services.login = {
    enableGnomeKeyring = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us,ir";
  #services.xserver.xkb.options = "eurosign:e,caps:escape, grp:shifts_toggle";
  services.xserver.xkb.options = "eurosign:e,caps:escape, grp:win_space_toggle";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.sane.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = false;
        Enable = "Source,Sink,Media,Socket";
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

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
    extraGroups =
      [ "networkmanager" "wheel" "scanner" "lp" "docker" "dialout" ];
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

  nix.settings.substituters = [
    # status: https://mirror.sjtu.edu.cn/
    # "https://mirror.sjtu.edu.cn/nix-channels/store"

    # status: https://mirrors.tuna.tsinghua.edu.cn/
    # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

    # status: https://mirrors.ustc.edu.cn/status/
    # "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  nix.settings.flake-registry = "";

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
    unstable.telegram-desktop
    # telegram-desktop
    btop
    libnotify
    pulseaudioFull
    dunst
    killall
    pkgs25.neovim
    gh
    neovide
    libgcc
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
    go
    unstable.nodejs_22
    python313
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
    typescript
    typescript-language-server
    svelte-language-server
    insomnia
    nixfmt-classic
    pkgs25.proxychains
    vscode-langservers-extracted
    python313Packages.python-lsp-server
    python313Packages.autopep8
    python313Packages.pip
    pyright
    zoxide
    fzf
    nest-cli
    dbeaver-bin
    # pkgs25.discord
    direnv
    prettier
    prettierd
    openssl
    prisma_7
    dotenv-cli
    eslint_d
    bun
    lzip
    dpkg
    csharp-ls
    pkgs25.dotnet-sdk_8
    ncompress
    codespell
    cspell
    wireguard-tools
    tree
    gdb
    nekoray
    # pkgs24.nekoray
    stylua
    black
    astyle
    pkgs25.obs-studio
    # kdePackages.kdenlive
    unrar
    pkgs25.tor-browser
    calibre
    gtk3
    gnupg
    pinentry-tty
    age
    wineWowPackages.stableFull
    winetricks
    lutris
    autoconf
    automake
    nasm
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.fa_IR
    vscode-extensions.vadimcn.vscode-lldb
    unstable.cargo
    unstable.rustc
    unstable.rust-analyzer
    unstable.rustfmt
    kdePackages.okular
    nomacs
    # onlyoffice-bin_latest
    unstable.libreoffice-qt6-fresh
    # wpsoffice
    virtualenv
    glibc
    zip
    fastfetch
    alsa-utils
    electron
    kdePackages.kcharselect
    docker-compose
    git
    pkgs25.wireshark
    (writeShellScriptBin "xon" ''
      echo "$(nohup nautilus . -w 1>/dev/null 2>/dev/null & exit 1>/dev/null)" | sh'')
    unstable.tailwindcss-language-server
    emmet-ls
    pkgs24.jan
    # jan
    mkcert
    appimage-run
    pkgs24.mesa
    libGLU
    pkgs24.mesa-demos
    pkgs25.gimp-with-plugins
    playerctl
    cmus
    yt-dlp
    p7zip
    pkgs25.musescore
    inetutils
    dig
    xray
    llama-cpp
    zellij
    v2rayn
    nix-serve-ng
    jq
    iperf
    go
    gopls
    vivaldi
    lsof
    file
    nix-index
    # hiddify-app
    pkgs23.sing-box
    # spotify
    bicon
    tcpdump
    pkgs25.eww
    buf
    protoc-gen-connect-go
    xwinwrap
    xdotool
    cmake
    qemu
    wmctrl
    xdo
    xorg.xwininfo
    revanced-cli
    # wails deps
    webkitgtk_4_1
    obsidian
    ffmpeg-full
    brightnessctl
    bluez
    bluez-tools
    # dart
    mangohud
    flutter
    # fastfetch
    #opengl
    pkgs.libGL # OpenGL
    pkgs.glfw # window/context creation
    pkgs.glew # OpenGL function loader
    pkgs.freeglut
    gcc
    codex
    p11-kit
    OVMF
    busybox
    virtio-win
    mlocate
    steghide
    gcc-arm-embedded
    amnezia-vpn
    picocom
    godot
    guitarix
    kdePackages.kdenlive
    libsecret
  ];

  programs.gamemode.enable = true;
  programs.nix-ld.enable = true;
  programs.kdeconnect.enable = true;

  programs.proxychains = {
    enable = true;
    proxies = {
      prx1 = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 3090;
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
    40443
    8443
    80
    8081
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
    8190 # local socks5
    8199 # local socks5
    3090
    3080
    7090
    7091
    7092
    7093
  ];

  networking.firewall.allowedUDPPorts = [
    8472 # k3s, flannel: required if using multi-node for inter-node networking
    8190 # local socks5
    8199 # local socks5
  ];

  networking.extraHosts = ''
    127.0.0.1 excali
    ::1 excali
  '';

  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # dns
  networking.networkmanager.dns = "none";
  # networking.nameservers = [ "185.51.200.2" "178.22.122.100" ]; # shecan
  # networking.nameservers = [ "172.29.0.100" "172.29.2.100" ]; # hostiran
  # networking.nameservers = [ "10.202.10.202" "10.202.10.102" ]; # 403
  # networking.nameservers = [ "193.186.32.32" ]; # bertina
  networking.nameservers = [
    "94.232.168.103"
    "194.225.152.12"
    "194.225.152.10"
    "185.95.155.177"
    "10.104.204.15"
    "10.104.205.23"
    "10.104.205.183"
    "10.104.204.183"
    "10.104.209.87"
    "78.157.52.0"
  ]; # misc
  # networking.nameservers = [ "8.8.8.8" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
