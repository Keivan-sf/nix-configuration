{ pkgs, ... }: {
  imports = [ ./home-base.nix ];
  xdg.configFile."i3/config".source = ./dotfiles/i3/laptop;
  xdg.configFile."neovide/config.toml".source =
    ./dotfiles/neovide/config-laptop.toml;
  programs.zsh.shellAliases.update =
    "sudo nixos-rebuild switch --flake .#laptop";
  programs.zsh.shellAliases.pupdate = let
    pupdatebin = pkgs.writeScriptBin "pupdate" ''
      SYSTEM_NAME='laptop'
       ${builtins.readFile ./scripts/pupdate.sh}'';
  in "${pupdatebin}/bin/pupdate";
}
