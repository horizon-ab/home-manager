{
  description = "Home Manager configuration of bsay";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "github:horizon-ab/wallpapers";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixGL,
      stylix,
      wallpapers,
      ...
    }:
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      homeConfigurations."bsay" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          ./stylix.nix
          stylix.homeManagerModules.stylix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit wallpapers nixGL; };
      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
