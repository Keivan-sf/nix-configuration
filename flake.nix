{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations =
      let
        system = "x86_64-linux";
        specialArgs = inputs // {
          unstable = inputs.unstable.legacyPackages.${system};
        };
      in
      {
        pc = nixpkgs.lib.nixosSystem {
          specialArgs = specialArgs;
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
  };
}
