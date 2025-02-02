# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /home/keive/nix-configuration/hardware-configuration.nix
    #./hardware-configuration.nix
    ./conf-base.nix
  ];

  boot.kernelModules = [ "kvm-intel" "i2c-dev" ];

  fileSystems."/winlean" = {
    device = "/dev/disk/by-uuid/01DAA516DB159820";
    fsType = "ntfs";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  #  boot.loader.systemd-boot.enable = true;

  # home 
  home-manager.users.keive = { imports = [ ./home-pc.nix ]; };

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    i2c-tools
    waybar
    wofi
    hyprpaper
    mako
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin =
        "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

}
