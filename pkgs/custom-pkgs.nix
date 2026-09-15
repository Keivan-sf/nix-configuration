{ config, pkgs, pkgs25, spicePkgs, ... }:

let
  hiddify = import ./packages/hiddify/hiddify.nix { inherit (pkgs) ; };
  webwp = pkgs.callPackage ./packages/webwp/webkitwp.nix { pkgs = pkgs; };
  godot-nvim =
    pkgs.callPackage ./packages/godot-nvim/default.nix { inherit pkgs25; };
  puzzletemp = pkgs.callPackage ./packages/puzzletemp/default.nix { };
  local-cmd-runner = pkgs.callPackage ./packages/local-cmd-runner/default.nix { };
  zira-code =
    pkgs.callPackage ./fonts/zira-code/zira-code.nix { inherit (pkgs) ; };
in {
  environment.systemPackages =
    [ webwp hiddify godot-nvim puzzletemp local-cmd-runner ];
  fonts.packages = [ zira-code ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [ adblockify ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
