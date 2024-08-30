# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration-pc.nix
    ./conf-base.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;


  # home 
  home-manager.users.keive = { imports = [ ./home-pc.nix ]; };

  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    i2c-tools
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
}
