{
  description = "Dots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
      modules = [ ./machines/suli ];
    };

    nixOnDroidConfigurations.tawa = nix-on-droid.lib.nixOnDroidConfiguration {
      extraSpecialArgs = {inherit inputs;};
      pkgs = import nixpkgs { system = "aarch64-linux"; };
      modules = [ ./machines/tawa ];
    };
  };
}
