{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    Neve.url = "github:redyf/Neve";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = let
      system = "x86_64-linux";
      specialArgs = inputs // {
        unstable = inputs.unstable.legacyPackages.${system};
        neve = inputs.Neve.packages.${system};
        secrets = import /etc/secrets.nix;
      };
    in {
      pc = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        modules = [ ./conf-pc.nix inputs.home-manager.nixosModules.default ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        modules =
          [ ./conf-laptop.nix inputs.home-manager.nixosModules.default ];
      };

    };
  };
}
