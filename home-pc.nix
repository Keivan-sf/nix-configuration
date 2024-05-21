{ pkgs, ... }: {
  imports = [./home-base.nix];
  xdg.configFile."i3/config".source = ./dotfiles/i3/pc;
  xdg.configFile."i3/i3-volume".source = ./dotfiles/i3/i3-volume;
  xdg.configFile."neovide/config.toml".source = ./dotfiles/neovide/config-pc.toml;
  programs.zsh.shellAliases.update = "sudo nixos-rebuild switch --flake .#pc";
  programs.zsh.shellAliases.pupdate = let pupdatebin = pkgs.writeScriptBin "pupdate" "SYSTEM_NAME='pc'\n${builtins.readFile ./scripts/pupdate.sh}"; in "${pupdatebin}/bin/pupdate";
}
