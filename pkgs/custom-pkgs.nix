{ config, pkgs, spicePkgs, ... }:

let
  hiddify = import ./packages/hiddify/hiddify.nix { inherit (pkgs) ; };
  webwp = pkgs.callPackage ./packages/webwp/webkitwp.nix { pkgs = pkgs; };
  zira-code =
    pkgs.callPackage ./fonts/zira-code/zira-code.nix { inherit (pkgs) ; };
in {
  environment.systemPackages = [ webwp hiddify ];
  fonts.packages = [ zira-code ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [ adblockify ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
