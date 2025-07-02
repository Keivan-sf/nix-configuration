{ config, pkgs, ... }:

let hiddify = import ./packages/hiddify.nix { inherit (pkgs) ; };
in { environment.systemPackages = [ hiddify ]; }
