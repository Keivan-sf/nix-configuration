{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs24.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs23.url = "github:NixOS/nixpkgs/nixos-23.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = let
      system = "x86_64-linux";
      specialArgs = inputs // {
        # unstable = inputs.unstable.legacyPackages.${system};
        unstable = import inputs.unstable {inherit system; config.allowUnfree = true; };
        pkgs24 = inputs.nixpkgs24.legacyPackages.${system};
        pkgs23 = inputs.nixpkgs23.legacyPackages.${system};
        #secrets = import /etc/secrets.nix;
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
