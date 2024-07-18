{
  description = "Dots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    site-builder = {
      url = "github:janElikan/site-builder";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05"; # gotta use stable ig
    };
  };

  outputs = { self, nixpkgs, nix-on-droid, ... }@inputs: {
    nixosConfigurations.suli = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./machines/suli
      ];
    };

    nixOnDroidConfigurations.tawa = nix-on-droid.lib.nixOnDroidConfiguration {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        ./machines/tawa
      ];
    };
  };
}
