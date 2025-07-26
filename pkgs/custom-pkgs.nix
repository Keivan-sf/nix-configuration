{ config, pkgs, ... }:

let
  hiddify = import ./packages/hiddify.nix { inherit (pkgs) ; };
  zira-code =
    pkgs.callPackage ./fonts/zira-code/zira-code.nix { inherit (pkgs) ; };
in {
  # environment.systemPackages = [ hiddify ];
  fonts.packages = [ zira-code ];
}
