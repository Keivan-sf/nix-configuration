# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, neve, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration-pc.nix
      ./conf-base.nix
    ];
  # home 
  home-manager.users.keive = {
    imports = [ ./home-laptop.nix ];
  };
}
