{ config, pkgs, spicePkgs, ... }:

let
  hiddify = import ./packages/hiddify.nix { inherit (pkgs) ; };
  zira-code =
    pkgs.callPackage ./fonts/zira-code/zira-code.nix { inherit (pkgs) ; };
  # spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};

in {
  # environment.systemPackages = [ hiddify ];
  fonts.packages = [ zira-code ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [ adblockify ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
