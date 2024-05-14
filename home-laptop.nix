{ ... }: {
  imports = [./home-base.nix];
  xdg.configFile."i3/config".source = ./dotfiles/i3/laptop;
  programs.zsh.shellAliases.update = "sudo nixos-rebuild switch --flake .#laptop";
}
