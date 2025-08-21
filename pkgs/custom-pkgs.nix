{ config, pkgs, spicePkgs, ... }:

let
  hiddify = import ./packages/hiddify/hiddify.nix { inherit (pkgs) ; };
  webwp = pkgs.callPackage ./packages/webwp/webkitwp.nix { inherit (pkgs) ; };
  zira-code =
    pkgs.callPackage ./fonts/zira-code/zira-code.nix { inherit (pkgs) ; };
  # spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};

in {
  environment.systemPackages = [ webwp ];
  fonts.packages = [ zira-code ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [ adblockify ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
